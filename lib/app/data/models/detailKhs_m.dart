// To parse this JSON data, do
//
//     final detailKhs = detailKhsFromJson(jsonString);

import 'dart:convert';

DetailKhs detailKhsFromJson(String str) => DetailKhs.fromJson(json.decode(str));

String detailKhsToJson(DetailKhs data) => json.encode(data.toJson());

class DetailKhs {
    DetailKhs({
        required this.totalSks,
        required this.ip,
        required this.ipk,
        required this.data,
    });

    int totalSks;
    String ip;
    String ipk;
    Map data;

    factory DetailKhs.fromJson(Map<String, dynamic> json) => DetailKhs(
        totalSks: json["total_sks"],
        ip: json["ip"],
        ipk: json["ipk"],
        data: jsonDecode(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "total_sks": totalSks,
        "ip": ip,
        "ipk": ipk,
        "data": data,
    };
}
