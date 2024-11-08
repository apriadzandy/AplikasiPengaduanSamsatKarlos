// lib/controllers/main_controller.dart
import 'package:get/get.dart';

class AdminDasboardController extends GetxController {
  // Observable variable untuk menyimpan index tab yang aktif
  var selectedIndex = 1.obs;

  // Method untuk mengubah index saat tombol navigasi ditekan
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
