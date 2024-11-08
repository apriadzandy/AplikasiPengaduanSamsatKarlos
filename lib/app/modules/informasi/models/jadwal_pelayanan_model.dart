class JadwalPelayananModel {
  String senin;
  String selasa;
  String rabu;
  String kamis;
  String jumat;
  String sabtu;

  JadwalPelayananModel({
    required this.senin,
    required this.selasa,
    required this.rabu,
    required this.kamis,
    required this.jumat,
    required this.sabtu,
  });

  // Convert model to Map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'senin': senin,
      'selasa': selasa,
      'rabu': rabu,
      'kamis': kamis,
      'jumat': jumat,
      'sabtu': sabtu,
    };
  }

  // Convert Map to Model (from Firestore)
  factory JadwalPelayananModel.fromJson(Map<String, dynamic> json) {
    return JadwalPelayananModel(
      senin: json['senin'],
      selasa: json['selasa'],
      rabu: json['rabu'],
      kamis: json['kamis'],
      jumat: json['jumat'],
      sabtu: json['sabtu'],
    );
  }
}
