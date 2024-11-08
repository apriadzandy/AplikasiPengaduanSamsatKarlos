// riwayat_pengaduan_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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
}