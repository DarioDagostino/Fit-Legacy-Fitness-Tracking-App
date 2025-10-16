import 'package:fit_legacy/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileRepositoryInterface {
  Future<UserModel> getUserProfile(String uid);
  Future<void> updateDisplayName(String uid, String newName);
  Future<String> uploadProfilePicture(String uid, XFile imageFile);
  Future<void> updateUserPhotoURL(String uid, String photoURL);
}