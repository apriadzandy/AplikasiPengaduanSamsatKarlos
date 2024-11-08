import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/controller/jadwalPelayanan_controller.dart';

class UserJadwalPelayananPage extends StatelessWidget {
  final Color _primaryColor = Color.fromARGB(255, 73, 124, 171);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JadwalPelayananController());
    controller.fetchJadwal();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Pelayanan',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _primaryColor,
              _primaryColor.withOpacity(0.7),
            ],
          ),
        ),
        child: Obx(
          () => ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              _buildHeaderCard(),
              SizedBox(height: 20),
              _buildJadwalCard(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 50,
              color: _primaryColor,
            ),
            SizedBox(height: 10),
            Text(
              'Jadwal Pelayanan',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Informasi waktu layanan untuk setiap hari',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalCard(JadwalPelayananController controller) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildJadwalItem('Senin', controller.jadwal.value.senin),
            _buildDivider(),
            _buildJadwalItem('Selasa', controller.jadwal.value.selasa),
            _buildDivider(),
            _buildJadwalItem('Rabu', controller.jadwal.value.rabu),
            _buildDivider(),
            _buildJadwalItem('Kamis', controller.jadwal.value.kamis),
            _buildDivider(),
            _buildJadwalItem('Jumat', controller.jadwal.value.jumat),
            _buildDivider(),
            _buildJadwalItem('Sabtu', controller.jadwal.value.sabtu),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalItem(String hari, String waktu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$hari',
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
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
    );
  }
}