import 'package:aplikasipengaduansamsatkarlos/app/modules/Login_Register/controllers/auth_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/controllers/pengaduan_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/controllers/riwayat_pengaduan_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/controllers/survey_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Mendaftarkan AuthController dan SettingController
  Get.put(AuthController());
  Get.put(SurveyController());
  Get.put(PengaduanController());
  Get.put(RiwayatPengaduanController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set initial route ke halaman login
      getPages: AppPages.routes,
    );
  }
}
