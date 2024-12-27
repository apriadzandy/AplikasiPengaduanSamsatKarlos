import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/controllers/survey_controller.dart';

class SurveyPage extends StatelessWidget {
  final SurveyController controller = Get.put(SurveyController());

  Widget _buildRatingOption(int value, RxInt rating) {
    return Obx(() => GestureDetector(
          onTap: () => rating.value = value,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: rating.value == value ? Colors.blueAccent : Colors.blue.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                if (rating.value == value) 
                  BoxShadow(color: Colors.blueAccent.withOpacity(0.5), blurRadius: 6, spreadRadius: 1)
              ],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: rating.value == value ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
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
                padding: EdgeInsets.only(top: 6),
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
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
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
            SizedBox(height: 20),
            // Menambahkan input untuk saran
            Text('Saran (Opsional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) => controller.saran.value = value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(),
                hintText: 'Masukkan saran atau komentar Anda...',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => controller.submitSurvey(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
