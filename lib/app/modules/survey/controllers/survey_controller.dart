import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/models/survey_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyController extends GetxController {
  final keramahan = 0.obs;
  final kecepatan = 0.obs;
  final informasi = 0.obs;
  final kenyamanan = 0.obs;
  final kepuasanTotal = 0.obs;
  final saran = ''.obs;

  // Tambahkan ini untuk menyimpan daftar survei
  final surveyList = <SurveyModel>[].obs;

  // Fungsi untuk mereset semua nilai
  void resetSurvey() {
    keramahan.value = 0;
    kecepatan.value = 0;
    informasi.value = 0;
    kenyamanan.value = 0;
    kepuasanTotal.value = 0;
    saran.value = '';
  }

  // Fungsi untuk mengambil survei dari Firestore
  Future<void> fetchSurveys() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('surveys')
          .orderBy('timestamp', descending: true)
          .get();
      
      // Ubah data dari Firestore ke dalam List<SurveyModel>
      surveyList.value = querySnapshot.docs.map((doc) {
        return SurveyModel.fromJson(doc.data());
      }).toList();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data survei',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> submitSurvey() async {
    // Cek apakah semua pertanyaan sudah dijawab
    if (keramahan.value == 0 ||
        kecepatan.value == 0 ||
        informasi.value == 0 ||
        kenyamanan.value == 0 ||
        kepuasanTotal.value == 0) {
      Get.snackbar(
        'Peringatan',
        'Mohon isi semua pertanyaan survey',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Ambil uid dari Firebase Auth
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar(
        'Error',
        'Pengguna tidak ditemukan, silakan login terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Ambil nama pengguna dari Firestore
    String namaPengguna = user.displayName ?? 'Pengguna Tanpa Nama';

    // Jika nama pengguna tidak tersedia di FirebaseAuth, kita bisa mengambilnya dari Firestore
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        namaPengguna = userDoc.data()?['username'] ?? namaPengguna;
      }
    } catch (e) {
      print("Gagal mengambil nama pengguna dari Firestore: $e");
    }

    try {
      final survey = SurveyModel(
        keramahan: keramahan.value,
        kecepatan: kecepatan.value,
        informasi: informasi.value,
        kenyamanan: kenyamanan.value,
        kepuasanTotal: kepuasanTotal.value,
        timestamp: DateTime.now(),
        saran: saran.value.isEmpty ? null : saran.value,
        namaPengguna: namaPengguna,  // Menyimpan nama pengguna
      );

      await FirebaseFirestore.instance.collection('surveys').add(survey.toJson());

      // Reset survey setelah berhasil tersimpan
      resetSurvey();

      Get.snackbar(
        'Sukses',
        'Terima kasih atas feedback Anda',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat menyimpan data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
