import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  RxString username = ''.obs;
  RxString profileImageUrl = ''.obs;
  RxString email = ''.obs; // Tambahkan properti email

  @override
  void onInit() {
    super.onInit();
    loadUserProfile(); // Muat profil pengguna saat controller diinisialisasi
  }

  Future<void> loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        username.value = userDoc['username'] ?? 'User Name';
        profileImageUrl.value = userDoc['profileImageUrl'] ?? '';
        email.value = user.email ?? 'No Email'; // Muat email pengguna
      }
    }
  }

  Future<void> updateUsername(String newUsername) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': newUsername,
      });
      username.value = newUsername;
      Get.snackbar('Success', 'Username updated successfully');
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String filePath = 'profile_images/${user.uid}.png';
        await _storage.ref(filePath).putFile(imageFile);

        String downloadUrl = await _storage.ref(filePath).getDownloadURL();

        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });
        profileImageUrl.value = downloadUrl;

        Get.snackbar('Success', 'Profile image updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image: $e');
      }
    }
  }

  Future<void> deleteProfileImage() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        String filePath = 'profile_images/${user.uid}.png';
        await _storage.ref(filePath).delete();

        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': '',
        });
        profileImageUrl.value = '';

        Get.snackbar('Success', 'Profile image deleted successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete image: $e');
      }
    }
  }
}
