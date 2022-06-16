// To parse this JSON data, do
//
//     final jadwalAbsensiModel = jadwalAbsensiModelFromJson(jsonString);

import 'dart:convert';

JadwalAbsensiModel jadwalAbsensiModelFromJson(String str) =>
    JadwalAbsensiModel.fromJson(json.decode(str));

class JadwalAbsensiModel {
  JadwalAbsensiModel({
    required this.jadwalKuliah,
    required this.absensi,
    required this.error,
  });

  final JadwalKuliah? jadwalKuliah;
  final Absensi? absensi;
  final bool error;

  factory JadwalAbsensiModel.fromJson(Map<String, dynamic> json) =>
      JadwalAbsensiModel(
        jadwalKuliah: json["jadwal_kuliah"] == null
            ? null
            : JadwalKuliah.fromJson(json["jadwal_kuliah"]),
        absensi:
            json["absensi"] == null ? null : Absensi.fromJson(json["absensi"]),
        error: json["error"] == null ? null : json["error"],
      );
}

class Absensi {
  Absensi({
    required this.data,
    required this.total,
  });

  final List<AbsensiDatum>? data;
  final int total;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
        data: json["data"] == null
            ? null
            : List<AbsensiDatum>.from(
                json["data"].map((x) => AbsensiDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
      );
}

class AbsensiDatum {
  AbsensiDatum({
    required this.matkul,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  final String matkul;
  final DateTime? date;
  final String startTime;
  final String endTime;

  factory AbsensiDatum.fromJson(Map<String, dynamic> json) => AbsensiDatum(
        matkul: json["matkul"] == null ? null : json["matkul"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
      );
}

class JadwalKuliah {
  JadwalKuliah({
    required this.data,
    required this.total,
  });

  final List<JadwalKuliahDatum>? data;
  final int total;

  factory JadwalKuliah.fromJson(Map<String, dynamic> json) => JadwalKuliah(
        data: json["data"] == null
            ? null
            : List<JadwalKuliahDatum>.from(
                json["data"].map((x) => JadwalKuliahDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
      );
}

class JadwalKuliahDatum {
  JadwalKuliahDatum({
    required this.matkul,
    required this.kelas,
    required this.materi,
  });

  final String matkul;
  final String? kelas;
  final String materi;

  factory JadwalKuliahDatum.fromJson(Map<String, dynamic> json) =>
      JadwalKuliahDatum(
        matkul: json["matkul"] == null ? null : json["matkul"],
        kelas: json["kelas"] == null ? null : json["kelas"],
        materi: json["materi"] == null ? null : json["materi"],
      );

  Map<String, dynamic> toJson() => {
        "matkul": matkul == null ? null : matkul,
        "kelas": kelas == null ? null : kelas,
        "materi": materi == null ? null : materi,
      };
}
