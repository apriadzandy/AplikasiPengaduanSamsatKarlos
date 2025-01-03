import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Profile/controllers/profile_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Login_Register/controllers/auth_controller.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Profile/views/profile_setting_view.dart';

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(226, 0, 77, 153),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(0, 255, 255, 255),
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color.fromARGB(236, 238, 238, 238),
                      backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                          ? NetworkImage(profileController.profileImageUrl.value)
                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                    );
                  }),
                  SizedBox(height: 15),
                  Obx(() {
                    return Column(
                      children: [
                        Text(
                          profileController.username.value.isNotEmpty
                              ? profileController.username.value
                              : 'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 5), // Jarak antara nama dan email
                        Text(
                          profileController.email.value.isNotEmpty
                              ? profileController.email.value
                              : 'No Email',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildProfileOption(
                    icon: Icons.settings,
                    title: 'Edit Profile',
                    onTap: () {
                      Get.to(ProfileSettingsView());
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      leading: Icon(
        icon,
        color: isLogout ? Colors.red[700] : Colors.blue[700],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red[700] : Colors.grey[800],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                authController.logoutUser();
              },
            ),
          ],
        );
      },
    );
  }
}
