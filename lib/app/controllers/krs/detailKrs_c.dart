import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/krs/krs_c.dart';
import 'package:gostrada/app/data/models/detailKrs_m.dart';
import 'package:http/http.dart' as http;

class DetailKrsController extends GetxController {
  final String detailKRS =
      'https://sia.iik-strada.ac.id/mobile/data/detail_krs';
  List<dynamic> dataDetailKrs = [];
  int totalSks = 0;
  var loadDetailKrs = true.obs;
  final c = Get.find<KrsController>();

  @override
  void onInit() async {
    final Map<String, dynamic> dataBody = {
      "nim": c.nim,
      "semester": c.semester,
    };

    // newValues = value;
    var response = await http.post(Uri.parse(detailKRS), body: dataBody);

    if (response.statusCode == 200) {
      var detail = jsonDecode(response.body);
      if (detail['error'] == true) {
        //
      } else {
        // load berhasil
        var result = DetailKrs.fromJson(detail);
        dataDetailKrs = result.data['data'];
        totalSks = result.totalSks;

        print('load master krs berhasil');
      }
      loadDetailKrs.value = false;
    }
    super.onInit();
  }

  downloadFile() async {
    final Map<String, dynamic> dataBody = {
      "semester_value": "1",
      "nim_value": "2151B1070",
    };
    Dio dio = Dio();
    var response = await dio.download(
      "https://sia.iik-strada.ac.id/mhs_krs/download_krs",'1/2151B1070',
      options: Options(
          headers: {
            "Accept": "application/json",
            // "semester_value": "1",
            // "nim_value": "2151B1070",
          },
          method: 'POST',

          followRedirects: false,
          validateStatus: (status) {
            print(status);
            return status! < 500;
          }),
      data: dataBody,
    );
  }
}
