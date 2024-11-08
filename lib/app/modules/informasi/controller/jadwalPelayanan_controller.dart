import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/models/jadwal_pelayanan_model.dart';
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
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('jadwal').doc('pelayanan').get();

      if (snapshot.exists) {
        jadwal.value = JadwalPelayananModel.fromJson(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data jadwal', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk update jadwal (untuk admin)
  Future<void> updateJadwal(String senin, String selasa, String rabu, String kamis, String jumat, String sabtu) async {
    try {
      await FirebaseFirestore.instance.collection('jadwal').doc('pelayanan').update({
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

      Get.snackbar('Sukses', 'Jadwal berhasil diupdate', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui jadwal', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
