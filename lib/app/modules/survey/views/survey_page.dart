// survey_page.dart
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/controllers/survey_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyPage extends StatelessWidget {
  final SurveyController controller = Get.put(SurveyController());

  Widget _buildRatingOption(int value, RxInt rating) {
    return Obx(() => GestureDetector(
          onTap: () => rating.value = value,
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: rating.value == value
                  ? Colors.blue
                  : Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
              border: rating.value == 0
                  ? Border.all(color: Colors.grey.shade400)
                  : null,
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: rating.value == value ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildQuestionRow(String question, RxInt rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            question,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => _buildRatingOption(index + 1, rating),
          ),
        ),
        Obx(() => rating.value == 0
            ? Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Silakan pilih nilai 1-5',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              )
            : SizedBox()),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Layanan KB. Samsat Karangploso'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionRow(
              'Apakah petugas kami melayani dengan ramah dan sopan?',
              controller.keramahan,
            ),
            _buildQuestionRow(
              'Seberapa cepat layanan yang Anda terima?',
              controller.kecepatan,
            ),
            _buildQuestionRow(
              'Apakah informasi yang diberikan sudah cukup jelas dan mudah dipahami?',
              controller.informasi,
            ),
            _buildQuestionRow(
              'Apakah Anda merasa nyaman dengan fasilitas yang ada di kantor Samsat kami?',
              controller.kenyamanan,
            ),
            _buildQuestionRow(
              'Seberapa puas Anda secara keseluruhan dengan layanan kami?',
              controller.kepuasanTotal,
            ),
            SizedBox(height: 16),
            // Menambahkan input untuk saran
            Text('Saran (Opsional)', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) => controller.saran.value = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan saran atau komentar Anda...',
              ),
              ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => controller.submitSurvey(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}