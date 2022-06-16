// To parse this JSON data, do
//
//     final masterKhsModel = masterKhsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MasterKhsModel masterKhsModelFromJson(String str) =>
    MasterKhsModel.fromJson(json.decode(str));

class MasterKhsModel {
  MasterKhsModel({
    required this.semesterAktif,
    required this.allSemester,
    required this.error,
  });

  final SemesterAktif? semesterAktif;
  final List<SemesterAktif>? allSemester;
  final bool error;

  factory MasterKhsModel.fromJson(Map<String, dynamic> json) => MasterKhsModel(
        semesterAktif: json["semester_aktif"] == null
            ? null
            : SemesterAktif.fromJson(json["semester_aktif"]),
        allSemester: json["all_semester"] == null
            ? null
            : List<SemesterAktif>.from(
                json["all_semester"].map((x) => SemesterAktif.fromJson(x))),
        error: json["error"] == null ? null : json["error"],
      );
}

class SemesterAktif {
  SemesterAktif({
    required this.semester,
    required this.ips,
    required this.periodeAktif,
  });

  final String semester;
  final String ips;
  final String periodeAktif;

  factory SemesterAktif.fromJson(Map<String, dynamic> json) => SemesterAktif(
        semester: json["semester"] == null ? null : json["semester"],
        ips: json["ips"] == null ? null : json["ips"],
        periodeAktif:
            json["periode_aktif"] == null ? null : json["periode_aktif"],
      );
}
