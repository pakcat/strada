// To parse this JSON data, do
//
//     final detailKrs = detailKrsFromJson(jsonString);

import 'dart:convert';


DetailKrs detailKrsFromJson(String str) => DetailKrs.fromJson(json.decode(str));


class DetailKrs {
    DetailKrs({
        required this.totalSks,
        required this.data,
    });

    int totalSks;
    var data;

    factory DetailKrs.fromJson(Map<String, dynamic> json) => DetailKrs(
        totalSks: json["total_sks"],
        data: jsonDecode(json["data"]),
    );

 
}
