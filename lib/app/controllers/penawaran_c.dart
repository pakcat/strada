import 'dart:convert';

import 'package:get/get.dart';
import 'package:gostrada/app/data/models/getsks.dart';
import 'package:gostrada/app/data/models/penawarankrs.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:http/http.dart' as http;
import '../data/models/test_m.dart';

class PenawaramKRSController extends GetxController {
  getmhs(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/penawaran_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);
      // print(DataUser['data']);

      //var test = jsonDecode(DataUser['data']);
      //print(test);

      // List list =
      //result2['data'].map((data) => DataModel.fromJson(data)).toList();
      // print(result2);
      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = GetMhsModel.fromJson(databody);

        return result;
      }
    } else {}
  }

  getsks(String nim, String semester) async {
    final Map<String, dynamic> dataBody = {
      GetSks.nim: nim,
      GetSks.semester: semester
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/penawaran_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);
      // print(DataUser['data']);

      //var test = jsonDecode(DataUser['data']);
      //print(test);

      // List list =
      //result2['data'].map((data) => DataModel.fromJson(data)).toList();
      // print(result2);
      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = GetSksModel.fromJson(databody);

        return result;
      }
    }
  }

  Submit(String nim, String semester, String accept) async {
    final Map<String, dynamic> dataBody = {
      InputPenawaran.nim: nim,
      InputPenawaran.semester: semester,
      InputPenawaran.accept: accept
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/penawaran_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);
      // print(DataUser['data']);

      //var test = jsonDecode(DataUser['data']);
      //print(test);

      // List list =
      //result2['data'].map((data) => DataModel.fromJson(data)).toList();
      // print(result2);
      if (databody['error'] == true) {
        //show error

      } else {
        Get.snackbar('Hi', dataBody["pesan"]);
        Get.toNamed(RoutName.root);
      }
    }
  }
}
