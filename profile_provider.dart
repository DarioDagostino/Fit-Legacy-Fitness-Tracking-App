import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/profile_repository.dart';
import 'package:image_picker/image_picker.dart';

enum ProfileStatus { Idle, Loading, Loaded, Error }

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  ProfileStatus _status = ProfileStatus.Idle;
  UserModel? _userProfile;
  String? _errorMessage;

  ProfileStatus get status => _status;
  UserModel? get userProfile => _userProfile;
  String? get errorMessage => _errorMessage;

  Future<void> loadUserProfile(User user) async {
    if (_status == ProfileStatus.Loading || (_status == ProfileStatus.Loaded && _userProfile?.uid == user.uid)) {
      return;
    }
    _status = ProfileStatus.Loading;
    notifyListeners();
    try {
      _userProfile = await _profileRepository.getUserProfile(user.uid);
      _status = ProfileStatus.Loaded;
    } catch (e) {
      _status = ProfileStatus.Error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<bool> updateDisplayName(String newName) async {
    if (_userProfile == null) return false;

    _status = ProfileStatus.Loading;
    notifyListeners();

    try {
      await _profileRepository.updateDisplayName(_userProfile!.uid, newName);
      await loadUserProfile(FirebaseAuth.instance.currentUser!); // Reload profile
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProfileStatus.Error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> uploadProfilePicture() async {
    if (_userProfile == null) return false;

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return false;

    _status = ProfileStatus.Loading;
    notifyListeners();

    try {
      final downloadURL = await _profileRepository.uploadProfilePicture(_userProfile!.uid, image);
      await _profileRepository.updateUserPhotoURL(_userProfile!.uid, downloadURL);
      await loadUserProfile(FirebaseAuth.instance.currentUser!); // Reload profile
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ProfileStatus.Error;
      notifyListeners();
      return false;
    }
  }
}