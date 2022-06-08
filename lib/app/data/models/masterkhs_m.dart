// To parse this JSON data, do
//
//     final masterKhs = masterKhsFromJson(jsonString);

import 'dart:convert';

MasterKhs masterKhsFromJson(String str) => MasterKhs.fromJson(json.decode(str));

String masterKhsToJson(MasterKhs data) => json.encode(data.toJson());

class MasterKhs {
  MasterKhs({
    required this.nim,
    required this.name,
    required this.angkatan,
    required this.fakultas,
    required this.prodi,
    required this.semester,
  });

  String nim;
  String name;
  String angkatan;
  dynamic fakultas;
  String prodi;
  Map semester;

  factory MasterKhs.fromJson(Map<String, dynamic> json) => MasterKhs(
        nim: json["nim"],
        name: json["name"],
        angkatan: json["angkatan"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        semester: jsonDecode(json["semester"]),
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "name": name,
        "angkatan": angkatan,
        "fakultas": fakultas,
        "prodi": prodi,
        "semester": semester,
      };
}
