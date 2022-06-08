import 'package:meta/meta.dart';
import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    required this.data,
    required this.error,
  });

  final List<Datum> data;
  final bool error;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    required this.name,
    required this.nameBank,
    required this.norek,
    required this.atasnama,
  });

  final String name;
  final String nameBank;
  final String norek;
  final String atasnama;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        nameBank: json["name_bank"],
        norek: json["norek"],
        atasnama: json["atasnama"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "name_bank": nameBank,
        "norek": norek,
        "atasnama": atasnama,
      };
}
