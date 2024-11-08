import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance; // Inisialisasi Firebase Storage

  RxString username = ''.obs;
  RxString profileImageUrl = ''.obs;

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
      }
    }
  }

  Future<void> updateUsername(String newUsername) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': newUsername,
      });
      username.value = newUsername; // Update state username
      Get.snackbar('Success', 'Username updated successfully');
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Upload gambar ke Firebase Storage
      try {
        String filePath = 'profile_images/${user.uid}.png';
        await _storage.ref(filePath).putFile(imageFile);

        // Ambil URL gambar yang baru di-upload
        String downloadUrl = await _storage.ref(filePath).getDownloadURL();

        // Update URL gambar profil di Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });
        profileImageUrl.value = downloadUrl; // Update state image URL

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
        // Hapus gambar dari Firebase Storage
        String filePath = 'profile_images/${user.uid}.png';
        await _storage.ref(filePath).delete();

        // Hapus URL gambar profil di Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': '', // Set ke kosong
        });
        profileImageUrl.value = ''; // Update state image URL

        Get.snackbar('Success', 'Profile image deleted successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete image: $e');
      }
    }
  }
}
