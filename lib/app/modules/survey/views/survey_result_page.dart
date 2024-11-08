// survey_results_page.dart
import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/models/survey_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Survey'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('surveys').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          }

          final surveyDocs = snapshot.data?.docs;
          if (surveyDocs == null || surveyDocs.isEmpty) {
            return Center(child: Text('Belum ada data survey'));
          }

          return ListView.builder(
            itemCount: surveyDocs.length,
            itemBuilder: (context, index) {
              final data = surveyDocs[index].data() as Map<String, dynamic>;
              final survey = SurveyModel.fromJson(data);

              return Card(
  margin: EdgeInsets.all(10),
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${survey.namaPengguna}', // Menampilkan nama pengguna
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Keramahan: ${survey.keramahan}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Kecepatan: ${survey.kecepatan}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Informasi: ${survey.informasi}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Kenyamanan: ${survey.kenyamanan}',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          'Kepuasan Total: ${survey.kepuasanTotal}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Waktu: ${survey.timestamp?.toLocal()}',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  ),
);

            },
          );
        },
      ),
    );
  }
}
