import 'package:aplikasipengaduansamsatkarlos/app/modules/Login_Register/views/login_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        String role = userDoc.get('role') ?? 'user';

        if (role == 'admin') {
          Get.offNamed('/AdminDashboard');
        } else {
          Get.offNamed('/UserDashboard');
        }
      }
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'username': email.split('@')[0],
        'profileImageUrl': '',
        'role': 'user', // Tambahkan peran sebagai 'user' secara default
      });

      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
      );

      Get.off(LoginPage());
    } catch (error) {
      Get.snackbar(
        'Error',
        'Registration failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user?.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': email,
          'username': email.split('@')[0],
          'profileImageUrl': '',
          'role': 'user', // Default role jika data baru
        });
      }

      String role = userDoc.get('role') ?? 'user';

      Get.snackbar(
        'Success',
        'Login successful',
        backgroundColor: Colors.green,
      );

      if (role == 'admin') {
        Get.offNamed('/AdminDashboard'); // Rute untuk admin
      } else {
        Get.offNamed('/UserDashboard'); // Rute untuk user biasa
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Login failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading.value = true;

      await _auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      Get.snackbar(
        'Success',
        'Logout successful',
        backgroundColor: Colors.green,
      );

      Get.off(LoginPage());
    } catch (error) {
      Get.snackbar(
        'Error',
        'Logout failed: $error',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
