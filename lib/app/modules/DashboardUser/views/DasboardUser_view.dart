// lib/views/main_view.dart
import 'package:aplikasipengaduansamsatkarlos/app/modules/DashboardUser/controllers/DasboardUser_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Profile/views/profile_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/home/views/home_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/views/UserjadwalPelayanan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserDasboardView extends StatelessWidget {
  final UserDasboardController controller = Get.put(UserDasboardController());  // Inject MainController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Mengatur tampilan berdasarkan index yang dipilih
        switch (controller.selectedIndex.value) {
          case 0:
              return UserJadwalPelayananPage();
          case 1:
              return HomePage();
          case 2:
              return ProfileView();
          default:
            return HomePage();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTabIndex,  // Panggil fungsi untuk mengubah index
        selectedItemColor: Colors.blue,    // Warna ikon yang terpilih menjadi biru
        unselectedItemColor: Colors.grey,  // Warna ikon yang tidak terpilih menjadi abu-abu
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'informasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(    
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
