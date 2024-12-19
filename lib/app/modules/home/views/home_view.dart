import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/views/pengaduan_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pertanyaan/views/question_page.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/views/survey_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final Color _primaryColor = Color(0xFF004D99); // Biru khas Samsat
  final Color _accentColor = Color.fromARGB(255, 28, 98, 189); // Kuning sebagai aksen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_primaryColor.withOpacity(0.9), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Logo Samsat dan Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo/logo.png', // Path logo baru
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pengaduan Samsat',
                      style: GoogleFonts.averiaLibre(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Logo Utama
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Image.asset(
                    'assets/images/logo/logoSAMSAT.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 20),
              // Footer
              Text(
                'Layanan Pengaduan Resmi Samsat Karang ploso',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontStyle: FontStyle.italic,
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
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: _accentColor, width: 1.5),
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
                  fontSize: 14,
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
