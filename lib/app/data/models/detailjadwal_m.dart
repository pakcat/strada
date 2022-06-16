// To parse this JSON data, do
//
//     final detailJadwalModel = detailJadwalModelFromJson(jsonString);

import 'dart:convert';

DetailJadwalModel detailJadwalModelFromJson(String str) =>
    DetailJadwalModel.fromJson(json.decode(str));

class DetailJadwalModel {
  DetailJadwalModel({
    required this.data,
    required this.total,
    required this.error,
  });

  final List<DetailJadwalModelDatum>? data;
  final int total;
  final bool error;

  factory DetailJadwalModel.fromJson(Map<String, dynamic> json) =>
      DetailJadwalModel(
        data: json["data"] == null
            ? null
            : List<DetailJadwalModelDatum>.from(
                json["data"].map((x) => DetailJadwalModelDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
        error: json["error"] == null ? null : json["error"],
      );
}

class DetailJadwalModelDatum {
  DetailJadwalModelDatum({
    required this.tahun,
    required this.data,
    required this.total,
  });

  final String tahun;
  final List<PurpleDatum>? data;
  final int total;

  factory DetailJadwalModelDatum.fromJson(Map<String, dynamic> json) =>
      DetailJadwalModelDatum(
        tahun: json["tahun"] == null ? null : json["tahun"],
        data: json["data"] == null
            ? null
            : List<PurpleDatum>.from(
                json["data"].map((x) => PurpleDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
      );
}

class PurpleDatum {
  PurpleDatum({
    required this.bulan,
    required this.data,
    required this.total,
  });

  final String bulan;
  final List<FluffyDatum>? data;
  final int total;

  factory PurpleDatum.fromJson(Map<String, dynamic> json) => PurpleDatum(
        bulan: json["bulan"] == null ? null : json["bulan"],
        data: json["data"] == null
            ? null
            : List<FluffyDatum>.from(
                json["data"].map((x) => FluffyDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
      );
}

class FluffyDatum {
  FluffyDatum({
    required this.tanggal,
    required this.labelTanggal,
    required this.data,
    required this.total,
  });

  final DateTime? tanggal;
  final String labelTanggal;
  final List<TentacledDatum>? data;
  final int total;

  factory FluffyDatum.fromJson(Map<String, dynamic> json) => FluffyDatum(
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        labelTanggal:
            json["label_tanggal"] == null ? null : json["label_tanggal"],
        data: json["data"] == null
            ? null
            : List<TentacledDatum>.from(
                json["data"].map((x) => TentacledDatum.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
      );
}

class TentacledDatum {
  TentacledDatum({
    required this.matkul,
    required this.kelas,
    required this.materi,
  });

  final String matkul;
  final String? kelas;
  final String materi;

  factory TentacledDatum.fromJson(Map<String, dynamic> json) => TentacledDatum(
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
