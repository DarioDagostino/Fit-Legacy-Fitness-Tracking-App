import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_fitness_data.dart';

/// Firebase Authentication Service
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in anonymously for demo purposes
  Future<UserCredential?> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      await _createUserDocument(result.user);
      return result;
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Update display name
      await result.user?.updateDisplayName(displayName);
      
      // Create user document
      await _createUserDocument(result.user, displayName: displayName);
      
      return result;
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(User? user, {String? displayName}) async {
    if (user == null) return;

    final userDoc = _firestore.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      final userData = UserFitnessData(
        uid: user.uid,
        displayName: displayName ?? user.displayName ?? 'Usuario',
        email: user.email ?? '',
        createdAt: DateTime.now(),
        dailyStepGoal: 10000,
        currentStreak: 0,
        bestStreak: 0,
        totalSteps: 0,
        achievements: [],
      );

      await userDoc.set(userData.toJson());
    }
  }
}

/// Firestore Service for fitness data
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user fitness data
  Stream<UserFitnessData?> getUserFitnessData(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            return UserFitnessData.fromJson(doc.data()!);
          }
          return null;
        });
  }

  // Update daily steps
  Future<void> updateDailySteps(String uid, int steps) async {
    final today = DateTime.now();
    final dateKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    
    await _firestore.collection('users').doc(uid).update({
      'dailySteps.$dateKey': steps,
      'totalSteps': FieldValue.increment(steps),
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  // Update step goal
  Future<void> updateStepGoal(String uid, int goal) async {
    await _firestore.collection('users').doc(uid).update({
      'dailyStepGoal': goal,
    });
  }

  // Add achievement
  Future<void> addAchievement(String uid, String achievementId) async {
    await _firestore.collection('users').doc(uid).update({
      'achievements': FieldValue.arrayUnion([achievementId]),
    });
  }

  // Update streak
  Future<void> updateStreak(String uid, int currentStreak, int bestStreak) async {
    await _firestore.collection('users').doc(uid).update({
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
    });
  }
}

// Providers
final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());

// Auth state provider
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

// Current user fitness data provider
final userFitnessDataProvider = StreamProvider<UserFitnessData?>((ref) {
  final authState = ref.watch(authStateProvider);
  final firestoreService = ref.watch(firestoreServiceProvider);
  
  return authState.when(
    data: (user) {
      if (user != null) {
        return firestoreService.getUserFitnessData(user.uid);
      }
      return Stream.value(null);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});