import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/controller/jadwalPelayanan_controller.dart';

class AdminJadwalPelayananPage extends StatelessWidget {
  final Color _primaryColor = Color.fromARGB(255, 73, 124, 171);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalPelayananController());
    controller.fetchJadwal();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin - Update Jadwal Pelayanan',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _primaryColor,
        elevation: 0,
      ),
      body: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan jadwal setiap hari
                _buildJadwalItem('Senin', controller.jadwal.value.senin),
                _buildJadwalItem('Selasa', controller.jadwal.value.selasa),
                _buildJadwalItem('Rabu', controller.jadwal.value.rabu),
                _buildJadwalItem('Kamis', controller.jadwal.value.kamis),
                _buildJadwalItem('Jumat', controller.jadwal.value.jumat),
                _buildJadwalItem('Sabtu', controller.jadwal.value.sabtu),
                
                SizedBox(height: 30),
                // Tombol untuk admin mengupdate jadwal
                ElevatedButton(
                  onPressed: () {
                    _showUpdateDialog(context, controller);
                  },
                  child: Text('Update Jadwal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget untuk menampilkan jadwal per hari
  Widget _buildJadwalItem(String hari, String waktu) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$hari:',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
        Text(
          waktu,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context, JadwalPelayananController controller) {
    TextEditingController seninController = TextEditingController();
    TextEditingController selasaController = TextEditingController();
    TextEditingController rabuController = TextEditingController();
    TextEditingController kamisController = TextEditingController();
    TextEditingController jumatController = TextEditingController();
    TextEditingController sabtuController = TextEditingController();

    seninController.text = controller.jadwal.value.senin;
    selasaController.text = controller.jadwal.value.selasa;
    rabuController.text = controller.jadwal.value.rabu;
    kamisController.text = controller.jadwal.value.kamis;
    jumatController.text = controller.jadwal.value.jumat;
    sabtuController.text = controller.jadwal.value.sabtu;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Update Jadwal Pelayanan',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(seninController, 'Senin'),
                _buildTextField(selasaController, 'Selasa'),
                _buildTextField(rabuController, 'Rabu'),
                _buildTextField(kamisController, 'Kamis'),
                _buildTextField(jumatController, 'Jumat'),
                _buildTextField(sabtuController, 'Sabtu'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Memperbarui jadwal
                controller.updateJadwal(
                  seninController.text,
                  selasaController.text,
                  rabuController.text,
                  kamisController.text,
                  jumatController.text,
                  sabtuController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  // Helper function untuk membuat TextField
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.roboto(
            color: Colors.grey[700],
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}