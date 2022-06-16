// To parse this JSON data, do
//
//     final ubb = ubbFromJson(jsonString);

import 'dart:convert';

Ubb ubbFromJson(String str) => Ubb.fromJson(json.decode(str));

String ubbToJson(Ubb data) => json.encode(data.toJson());

class Ubb {
  Ubb({
    required this.data,
    required this.error,
    required this.total,
  });

  final List<Datum> data;
  final bool error;
  final int total;

  factory Ubb.fromJson(Map<String, dynamic> json) => Ubb(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.isConfirm,
    required this.codeTrans,
    required this.nim,
    required this.periode,
    required this.note,
    required this.dibuat,
    required this.noteReject,
    required this.nominal,
    required this.uploads,
  });

  final String id;
  final String name;
  final String isConfirm;
  final String codeTrans;
  final String nim;
  final String periode;
  final String note;
  final DateTime dibuat;
  final dynamic noteReject;
  final String nominal;
  final dynamic uploads;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        isConfirm: json["is_confirm"],
        codeTrans: json["code_trans"],
        nim: json["nim"],
        periode: json["periode"],
        note: json["note"],
        dibuat: DateTime.parse(json["dibuat"]),
        noteReject: json["note_reject"],
        nominal: json["nominal"],
        uploads: json["uploads"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_confirm": isConfirm,
        "code_trans": codeTrans,
        "nim": nim,
        "periode": periode,
        "note": note,
        "dibuat": dibuat.toIso8601String(),
        "note_reject": noteReject,
        "nominal": nominal,
        "uploads": uploads,
      };
}
