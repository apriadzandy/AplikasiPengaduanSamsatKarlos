import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyModel {
  int? keramahan;
  int? kecepatan;
  int? informasi;
  int? kenyamanan;
  int? kepuasanTotal;
  DateTime? timestamp;
  String? saran;
  String? namaPengguna;  // Menambahkan field untuk nama pengguna

  SurveyModel({
    this.keramahan,
    this.kecepatan,
    this.informasi,
    this.kenyamanan,
    this.kepuasanTotal,
    this.timestamp,
    this.saran,
    this.namaPengguna,  // Constructor baru dengan nama pengguna
  });

  Map<String, dynamic> toJson() {
    return {
      'keramahan': keramahan,
      'kecepatan': kecepatan,
      'informasi': informasi,
      'kenyamanan': kenyamanan,
      'kepuasanTotal': kepuasanTotal,
      'timestamp': timestamp?.toIso8601String(),
      'saran': saran,
      'namaPengguna': namaPengguna, // Menyimpan nama pengguna
    };
  }

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      keramahan: json['keramahan'],
      kecepatan: json['kecepatan'],
      informasi: json['informasi'],
      kenyamanan: json['kenyamanan'],
      kepuasanTotal: json['kepuasanTotal'],
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] is Timestamp
              ? (json['timestamp'] as Timestamp).toDate()
              : DateTime.parse(json['timestamp']))
          : null,
      saran: json['saran'],
      namaPengguna: json['namaPengguna'], // Mengambil nama pengguna dari Firestore
    );
  }
}
