import 'dart:convert';

class MasterKrsModel {
  MasterKrsModel({
    required this.nim,
    required this.name,
    required this.angkatan,
    required this.fakultas,
    required this.prodi,
    //required this.semester,
  });

  String? nim;
  String? name;
  String? angkatan;
  dynamic fakultas;
  String? prodi;
  //String semester;

  factory MasterKrsModel.fromJson(Map<String, dynamic> json) => MasterKrsModel(
        nim: json["nim"] == null ? null : json["nim"],
        name: json["nama"] == null ? null : json["nim"],
        angkatan: ["angkatan"] == null ? null : json["angkatan"],
        fakultas: json["fakultas"],
        prodi: ["prodi"] == null ? null : json["prodi"],
        //semester: json["semester"],
      );
}
