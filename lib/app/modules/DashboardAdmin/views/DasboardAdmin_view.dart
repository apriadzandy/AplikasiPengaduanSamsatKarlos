// lib/views/main_view.dart
import 'package:aplikasipengaduansamsatkarlos/app/modules/DashboardAdmin/controllers/DasboardAdmin_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Profile/views/profile_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/home/views/home_admin_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/informasi/views/AdminjadwalPelayanan_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdminDasboardView extends StatelessWidget {
  final AdminDasboardController controller = Get.put(AdminDasboardController());  // Inject MainController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Mengatur tampilan berdasarkan index yang dipilih
        switch (controller.selectedIndex.value) {
          case 0:
              return AdminJadwalPelayananPage();
          case 1:
              return HomeAdminView();
          case 2:
              return ProfileView();
          default:
            return HomeAdminView();
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
