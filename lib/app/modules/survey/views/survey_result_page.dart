import 'package:aplikasipengaduansamsatkarlos/app/modules/survey/models/survey_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Survey', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Filter functionality can be added here
            },
          )
        ],
      ),
      body: Container(
        color: Colors.blueGrey[50], // Softer background color
        padding: EdgeInsets.all(10), // Padding to give more space around the edges
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('surveys').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan', style: TextStyle(fontSize: 16, color: Colors.red)));
            }

            final surveyDocs = snapshot.data?.docs;
            if (surveyDocs == null || surveyDocs.isEmpty) {
              return Center(child: Text('Belum ada data survey', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
            }

            return ListView.builder(
              itemCount: surveyDocs.length,
              itemBuilder: (context, index) {
                final data = surveyDocs[index].data() as Map<String, dynamic>;
                final survey = SurveyModel.fromJson(data);

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.blueGrey[100]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.blueAccent, size: 30),
                              SizedBox(width: 10),
                              Text(
                                '${survey.namaPengguna}', // Menampilkan nama pengguna
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          _buildSurveyDetail('Keramahan', survey.keramahan),
                          _buildSurveyDetail('Kecepatan', survey.kecepatan),
                          _buildSurveyDetail('Informasi', survey.informasi),
                          _buildSurveyDetail('Kenyamanan', survey.kenyamanan),
                          _buildSurveyDetail('Kepuasan Total', survey.kepuasanTotal),
                          SizedBox(height: 15),
                          Text(
                            'Waktu: ${survey.timestamp?.toLocal()}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSurveyDetail(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 20),
          SizedBox(width: 10),
          Text(
            '$label: $value',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
