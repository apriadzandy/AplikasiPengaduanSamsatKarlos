import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/Pengaduan/controllers/pengaduan_controller.dart';

class PengaduanView extends GetView<PengaduanController> {
  final Color primaryColor = Color.fromARGB(226, 0, 77, 153);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Pengaduan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderText(),
                  SizedBox(height: 20),
                  _buildNamaField(),
                  SizedBox(height: 16),
                  _buildNomorTeleponField(),
                  SizedBox(height: 16),
                  _buildEmailField(),
                  SizedBox(height: 16),
                  _buildAlamatField(),
                  SizedBox(height: 16),
                  _buildPengaduanField(),
                  SizedBox(height: 16),
                  _buildImageUploadSection(),
                  SizedBox(height: 24),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Sampaikan Pengaduan Anda',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );
  }

  Widget _buildNamaField() {
    return TextFormField(
      controller: controller.namaController,
      validator: controller.validateNama,
      decoration: _buildInputDecoration(
        labelText: 'Nama Lengkap',
        icon: Icons.person_outline,
      ),
      style: TextStyle(color: primaryColor),
    );
  }

  Widget _buildNomorTeleponField() {
    return TextFormField(
      controller: controller.nomorTeleponController,
      validator: controller.validateNomorTelepon,
      keyboardType: TextInputType.phone,
      decoration: _buildInputDecoration(
        labelText: 'Nomor Telepon',
        icon: Icons.phone_outlined,
      ),
      style: TextStyle(color: primaryColor),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      validator: controller.validateEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildInputDecoration(
        labelText: 'Email',
        icon: Icons.email_outlined,
      ),
      style: TextStyle(color: primaryColor),
    );
  }

  Widget _buildAlamatField() {
    return TextFormField(
      controller: controller.alamatController,
      maxLines: 2,
      decoration: _buildInputDecoration(
        labelText: 'Alamat',
        icon: Icons.location_on_outlined,
      ),
      style: TextStyle(color: primaryColor),
    );
  }

  Widget _buildPengaduanField() {
    return TextFormField(
      controller: controller.isiPengaduanController,
      maxLines: 4,
      decoration: _buildInputDecoration(
        labelText: 'Isi Pengaduan',
        icon: Icons.description_outlined,
      ),
      style: TextStyle(color: primaryColor),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bukti Pengaduan (Opsional)',
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImagePickerButton(
              icon: Icons.camera_alt,
              label: 'Kamera',
              onPressed: () => controller.pickImage(ImageSource.camera),
            ),
            _buildImagePickerButton(
              icon: Icons.photo,
              label: 'Galeri',
              onPressed: () => controller.pickImage(ImageSource.gallery),
            ),
          ],
        ),
        Obx(() {
          if (controller.selectedImage.value != null) {
            return Column(
              children: [
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      controller.selectedImage.value!, 
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: controller.removeImage,
                  child: Text(
                    'Hapus Gambar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.submitPengaduan,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: Text(
        'Kirim Pengaduan',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImagePickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: primaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius. circular(10),
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    );
  }
}