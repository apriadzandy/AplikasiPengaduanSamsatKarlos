import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/views/pengaduan_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pertanyaan/views/question_page.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/views/survey_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final Color _primaryColor = Color.fromARGB(255, 73, 124, 171);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor.withOpacity(0.8), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Logo Baru di Kiri Atas
              Padding(
                padding: const EdgeInsets.all(8.0), // Jarak dari tepi kiri dan atas
                child: Align(
                  alignment: Alignment.topLeft, // Menyelaraskan ke kiri atas
                  child: Container(
                    width: 90, // Sesuaikan ukuran logo
                    height: 60,
                    child: Image.asset(
                      'assets/images/logo/logo.png', // Path logo baru Anda
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Logo Tengah yang Sudah Ada
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo/logoSAMSAT.png', // Path logo utama
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 50),
              // Menu Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMenuButton(
                      icon: Icons.assignment_outlined,
                      label: 'Survey',
                      onTap: () {
                        Get.to(SurveyPage());
                      },
                    ),
                    _buildMenuButton(
                      icon: Icons.help_outline,
                      label: 'Pertanyaan',
                      onTap: () {
                        Get.to(ContactInfoPage());
                      },
                    ),
                    _buildMenuButton(
                      icon: Icons.chat_bubble_outline,
                      label: 'Pengaduan',
                      onTap: () {
                        Get.to(PengaduanView());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: _primaryColor,
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: _primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
