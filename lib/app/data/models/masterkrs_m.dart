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

  String nim;
  String name;
  String angkatan;
  dynamic fakultas;
  String prodi;
  //String semester;

  factory MasterKrsModel.fromJson(Map<String, dynamic> json) => MasterKrsModel(
        nim: json["nim"],
        name: json["name"],
        angkatan: json["angkatan"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        //semester: json["semester"],
      );
}
