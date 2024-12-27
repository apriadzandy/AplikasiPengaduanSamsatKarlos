// riwayat_pengaduan_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatPengaduanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream untuk mengambil data pengaduan
  Stream<QuerySnapshot> getPengaduanStream() {
    return _firestore
        .collection('pengaduan')
        .orderBy('tanggal', descending: true)
        .snapshots();
  }

  // Fungsi untuk memformat tanggal singkat
  String formatTanggalSingkat(Timestamp? timestamp) {
    if (timestamp == null) return '';
    
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // Fungsi untuk memformat tanggal detail
  String formatTanggalLengkap(Timestamp? timestamp) {
    if (timestamp == null) return 'Tanggal tidak tersedia';
    
    DateTime dateTime = timestamp.toDate();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
           'pukul ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} WIB';
  }

  void _deletePengaduan(String pengaduanId) async {
  try {
    // Menghapus data pengaduan dari Firestore berdasarkan ID
    await FirebaseFirestore.instance.collection('pengaduan').doc(pengaduanId).delete();

    // Menampilkan notifikasi berhasil menghapus data
    Get.snackbar(
      'Sukses',
      'Pengaduan berhasil dihapus',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  } catch (e) {
    // Menampilkan notifikasi gagal menghapus data
    Get.snackbar(
      'Gagal',
      'Gagal menghapus pengaduan: $e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

Future<void> hapusPengaduan(String pengaduanId) async {
    try {
      await _firestore.collection('pengaduan').doc(pengaduanId).delete();
      Get.snackbar('Pengaduan Dihapus', 'Pengaduan telah berhasil dihapus.',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Gagal Menghapus', 'Terjadi kesalahan saat menghapus pengaduan.',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
