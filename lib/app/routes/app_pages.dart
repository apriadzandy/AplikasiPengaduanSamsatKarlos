
import 'package:aplikasipengaduansamsatkarlos/app/modules/DashboardAdmin/views/DasboardAdmin_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/DashboardUser/views/DasboardUser_view.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Login_Register/views/login_Page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

abstract class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN; // Rute awal
  static const User = Routes.User;
  static const Admin = Routes.Admin;
  

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(), // Ganti dengan halaman login Anda
    ),
    GetPage(name: User, page: () => UserDasboardView()),
    GetPage(name: Admin, page: () => AdminDasboardView()),
    // Tambahkan GetPage lainnya jika diperlukan
  ];
}
