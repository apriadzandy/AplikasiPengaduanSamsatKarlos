import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/views/riwayatPengaduan_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/views/survey_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Theme Controller
class ThemeController extends GetxController {
  // Observable untuk menentukan apakah menggunakan tema event
  var isEventTheme = false.obs;

  // Fungsi toggle tema
  void toggleTheme() {
    isEventTheme.value = !isEventTheme.value;
  }
}

class HomeAdminView extends StatelessWidget {
  final Color _primaryColor = Color(0xFF004D99); // Biru khas Samsat
  final Color _accentColor = Color.fromARGB(255, 28, 98, 189); // Kuning sebagai aksen
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeColors = themeController.isEventTheme.value
          ? {
              "primaryColor": Colors.red,
              "accentColor": Colors.redAccent,
              "gradientStart": Colors.red.withOpacity(0.9),
              "gradientEnd": Colors.white,
            }
          : {
              "primaryColor": _primaryColor,
              "accentColor": _accentColor,
              "gradientStart": _primaryColor.withOpacity(0.9),
              "gradientEnd": Colors.white,
            };

      return Scaffold(
        appBar: AppBar(
          backgroundColor: themeColors["primaryColor"],
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo/logo.png',
                width: 60,
                height: 40,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Text(
                'Pengaduan Samsat',
                style: GoogleFonts.averiaLibre(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.color_lens, color: Colors.white),
              onPressed: themeController.toggleTheme,
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColors["gradientStart"]!,
                  themeColors["gradientEnd"]!
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 50),
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
                          Get.to(SurveyResultPage());
                        },
                      ),
                      _buildMenuButton(
                        icon: Icons.chat_bubble_outline,
                        label: 'Pengaduan',
                        onTap: () {
                          Get.to(RiwayatPengaduanView());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Footer
                Text(
                  'Layanan Pengaduan Resmi Samsat Karang Ploso',
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
    });
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
