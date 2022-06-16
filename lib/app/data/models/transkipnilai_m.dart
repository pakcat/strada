// To parse this JSON data, do
//
//     final transkipNilai = transkipNilaiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TranskipNilai transkipNilaiFromJson(String str) =>
    TranskipNilai.fromJson(json.decode(str));

class TranskipNilai {
  TranskipNilai({
    required this.data,
    required this.totalBobot,
    required this.ipk,
    required this.prestasi,
    required this.error,
  });

  final List<Datum>? data;
  final int totalBobot;
  final String ipk;
  final String prestasi;
  final bool error;

  factory TranskipNilai.fromJson(Map<String, dynamic> json) => TranskipNilai(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalBobot: json["total_bobot"] == null ? null : json["total_bobot"],
        ipk: json["ipk"] == null ? null : json["ipk"],
        prestasi: json["prestasi"] == null ? null : json["prestasi"],
        error: json["error"] == null ? null : json["error"],
      );
}

class Datum {
  Datum({
    required this.codeMk,
    required this.name,
    required this.bobot,
    required this.huruf,
    required this.nilaiIndex,
    required this.semester,
  });

  final String codeMk;
  final String name;
  final String bobot;
  final String huruf;
  final int nilaiIndex;
  final String semester;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        codeMk: json["code_mk"] == null ? null : json["code_mk"],
        name: json["name"] == null ? null : json["name"],
        bobot: json["bobot"] == null ? null : json["bobot"],
        huruf: json["huruf"] == null ? null : json["huruf"],
        nilaiIndex: json["nilai_index"] == null ? null : json["nilai_index"],
        semester: json["semester"] == null ? null : json["semester"],
      );
}
