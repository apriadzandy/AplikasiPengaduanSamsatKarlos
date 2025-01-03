import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class PengaduanController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Form Controllers
  final namaController = TextEditingController();
  final nomorTeleponController = TextEditingController();
  final emailController = TextEditingController();
  final alamatController = TextEditingController();
  final isiPengaduanController = TextEditingController();

  // Image picker
  final Rx<File?> selectedImage = Rx<File?>(null);

  // Validasi form
  String? validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama harus diisi';
    }
    return null;
  }

  String? validateNomorTelepon(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor Telepon harus diisi';
    }
    // Tambahkan validasi nomor telepon jika diperlukan
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email harus diisi';
    }
    // Validasi format email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // Pilih gambar dari galeri
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Hapus gambar yang dipilih
  void removeImage() {
    selectedImage.value = null;
  }

  // Fungsi untuk menampilkan dialog
  void _showDialog({required String title, required String message, required Color color}) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  // Submit pengaduan
  Future<void> submitPengaduan() async {
    if (formKey.currentState!.validate()) {
      try {
        // Upload gambar jika ada
        String? imageUrl;
        if (selectedImage.value != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('pengaduan_images/${DateTime.now().millisecondsSinceEpoch}');

          await storageRef.putFile(selectedImage.value!);
          imageUrl = await storageRef.getDownloadURL();
        }

        // Simpan data ke Firestore
        await FirebaseFirestore.instance.collection('pengaduan').add({
          'nama': namaController.text,
          'nomorTelepon': nomorTeleponController.text,
          'email': emailController.text,
          'alamat': alamatController.text,
          'isiPengaduan': isiPengaduanController.text,
          'buktiGambar': imageUrl,
          'tanggal': FieldValue.serverTimestamp(),
        });

        // Tampilkan dialog berhasil
        _showDialog(
          title: 'Berhasil',
          message: 'Pengaduan berhasil dikirim',
          color: Color.fromARGB(226, 0, 77, 153),
        );

        // Reset form
        formKey.currentState!.reset();
        namaController.clear();
        nomorTeleponController.clear();
        emailController.clear();
        alamatController.clear();
        isiPengaduanController.clear();
        selectedImage.value = null;

      } catch (e) {
        // Tampilkan dialog error
        _showDialog(
          title: 'Error',
          message: 'Gagal mengirim pengaduan: ${e.toString()}',
          color: Colors.red,
        );
      }
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    namaController.dispose();
    nomorTeleponController.dispose();
    emailController.dispose();
    alamatController.dispose();
    isiPengaduanController.dispose();
    super.onClose();
  }
}
