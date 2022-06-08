import 'dart:convert';

import 'package:get/get.dart';
import 'package:gostrada/app/controllers/khs/khs_c.dart';
import 'package:gostrada/app/data/models/detailKhs_m.dart';
import 'package:http/http.dart' as http;


class DetailKhsController extends GetxController{
  final String detailKHS =
      'https://sia.iik-strada.ac.id/mobile/data/detail_khs';
  List<dynamic> dataDetailKhs = [];
  int totalSks = 0;
  var loadDetailKhs = true.obs;
  var ips;
  var ipk;
  final c = Get.find<KHSController>();

  @override
  void onInit() async{
    final Map<String, dynamic> dataBody = {
      "nim": c.nim,
      "semester": c.semester,
    };

    

    // newValues = value;
    var response = await http.post(Uri.parse(detailKHS), body: dataBody);

    if (response.statusCode == 200) {
      var detail = jsonDecode(response.body);
      if (detail['error'] == true) {
        //
      } else {
        // load berhasil
        // print(detail.runtimeType);
        var result = DetailKhs.fromJson(detail);
        dataDetailKhs = result.data['data'];
        totalSks = result.totalSks;
        ips = result.ip;     
        ipk = result.ipk;     
        print(ips);
        print('load master krs berhasil');
      }
      loadDetailKhs.value = false;
    }
    super.onInit();
  }

}