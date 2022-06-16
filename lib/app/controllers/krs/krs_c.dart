import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/detailKhs_m.dart';
import 'package:gostrada/app/data/models/masterkhs_m.dart';
import 'package:gostrada/app/data/models/masterkrs_m.dart';
import 'package:gostrada/app/data/models/transkipnilai_m.dart';
import 'package:http/http.dart' as http;

import '../../data/models/detailKrs_m.dart';
import '../../data/models/test_m.dart';

class KrsController extends GetxController {
  final box = GetStorage();
  late Map data = box.read("dataUser") as Map<String, dynamic>;
  final String masterKRS =
      'https://sia.iik-strada.ac.id/mobile/Data/master_krs';
  masterkrs(String nim) async {
    final Map<String, dynamic> dataBody = {
      CodeVA.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/master_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = MasterKrs.fromJson(databody);

        return result;
      }
    }
  }

  detailkrs(String nim, String semester) async {
    final Map<String, dynamic> dataBody = {
      GetSks.nim: nim,
      GetSks.semester: semester
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/detail_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = DetailKrs.fromJson(databody);

        return result;
      }
    }
  }

  masterkhs(String nim) async {
    final Map<String, dynamic> dataBody = {
      CodeVA.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/master_khs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = MasterKhsModel.fromJson(databody);

        return result;
      }
    }
  }

  detailkhs(String nim, String semester) async {
    final Map<String, dynamic> dataBody = {
      GetSks.nim: nim,
      GetSks.semester: semester
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/detail_krs"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = DetailKhsModel.fromJson(databody);

        return result;
      }
    }
  }

  transkipnilai(String nim) async {
    final Map<String, dynamic> dataBody = {
      GetSks.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/data/transkip"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = TranskipNilai.fromJson(databody);

        return result;
      }
    }
  }
}
  
 
 

  // // downloadFile() async {
  // //   final Map<String, dynamic> dataBody = {
  // //     "semester_value": "1",
  // //     "nim_value": "2151B1070",
  // //   };
  // //   Dio dio = Dio();
  // //   var response = await dio.post("https://sia.iik-strada.ac.id/mhs_krs/download_krs",
  // //     options: Options(
  // //       headers: {"Accept": "application/json"},
  // //       // method: 'POST',
  // //       followRedirects: false,
  // //       validateStatus: (status) { return status! < 500; }
        
  // //     ),
  // //     data: dataBody,
  // //   );

  // //   print(response.statusCode);
  // // }

