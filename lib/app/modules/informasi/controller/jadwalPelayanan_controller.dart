import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/models/jadwal_pelayanan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JadwalPelayananController extends GetxController {
  var jadwal = JadwalPelayananModel(
    senin: '',
    selasa: '',
    rabu: '',
    kamis: '',
    jumat: '',
    sabtu: '',
  ).obs;

  // Fungsi untuk mengambil jadwal dari Firestore
  Future<void> fetchJadwal() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('jadwal').doc('pelayanan').get();

      if (snapshot.exists) {
        jadwal.value =
            JadwalPelayananModel.fromJson(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      // Menampilkan pop-up dialog saat terjadi error
      _showDialog(
        title: 'Error',
        message: 'Gagal mengambil data jadwal',
      );
    }
  }

  // Fungsi untuk update jadwal (untuk admin)
  Future<void> updateJadwal(String senin, String selasa, String rabu,
      String kamis, String jumat, String sabtu) async {
    try {
      await FirebaseFirestore.instance
          .collection('jadwal')
          .doc('pelayanan')
          .update({
        'senin': senin,
        'selasa': selasa,
        'rabu': rabu,
        'kamis': kamis,
        'jumat': jumat,
        'sabtu': sabtu,
      });

      // Update local state
      jadwal.value = JadwalPelayananModel(
        senin: senin,
        selasa: selasa,
        rabu: rabu,
        kamis: kamis,
        jumat: jumat,
        sabtu: sabtu,
      );

      // Menampilkan pop-up dialog sukses
      _showDialog(
        title: 'Sukses',
        message: 'Jadwal berhasil diupdate',
      );
    } catch (e) {
      // Menampilkan pop-up dialog saat terjadi error
      _showDialog(
        title: 'Error',
        message: 'Gagal memperbarui jadwal',
      );
    }
  }

  void _showDialog({required String title, required String message}) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: message,
      middleTextStyle: TextStyle(fontSize: 16, color: Colors.black54),
      backgroundColor: Colors.white,
      radius: 10,
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      buttonColor: Color.fromARGB(226, 0, 77, 153),
      onConfirm: () => Get.back(),
    );
  }
}
