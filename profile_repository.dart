import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromFirestore(doc);
  }

  Future<void> updateDisplayName(String uid, String newName) async {
    // Update in Firestore
    await _firestore.collection('users').doc(uid).update({'displayName': newName});

    // Update in FirebaseAuth
    await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
  }
}