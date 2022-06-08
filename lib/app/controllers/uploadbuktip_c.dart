import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/data/models/TPmodel.dart';
import 'package:gostrada/app/data/models/nominal.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/test_m.dart';
import 'package:http/http.dart' as http;

import '../data/models/ubb_m.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class UploadBuktiController extends GetxController {
  @override
  List<String> periode = [];
  List<String> idperiode = [];
  var txt = TextEditingController();
  List<String> kode = [];
  static UploadBuktiController get to => Get.find();
  UBB(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };
    var response = await http.post(
        Uri.parse(
            "https://sia.iik-strada.ac.id/mobile/keuangan/upload_bukti_bayar"),
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
        var result = Ubb.fromJson(databody);
        return result;
      }
    }
  }

  GetTP(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };
    var response = await http.post(
        Uri.parse(
            "https://sia.iik-strada.ac.id/mobile/keuangan/get_tambah_pembayaran"),
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
        var result = GetTpModel.fromJson(databody);
        periode.clear();
        kode.clear();
        idperiode.clear();
        for (var item in result.periode.data) {
          periode.add(item.name);
        }
        for (var item in result.periode.data) {
          idperiode.add(item.id);
        }
        for (var item in result.codeTrans.data) {
          kode.add(item.codeTrans);
        }

        return result;
      }
    }
  }

  getnominal(String code) async {
    final Map<String, dynamic> dataBody = {
      nominalModel.code: code,
    };
    var response = await http.post(
        Uri.parse(
            "https://sia.iik-strada.ac.id/mobile/keuangan/nominal_transaksi"),
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
        var result = NominalModel.fromJson(databody);
        txt.text = result.labelTotal;
        print(result);
        return result;
      }
    }
  }

  postbukti(image, String nim, String idperiode, String CodeTransaksi,
      String nominal_id) async {
    print(idperiode);
    File file = File(image.path);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://sia.iik-strada.ac.id/mobile/keuangan/input_tagihan'));
    request.fields.addAll({
      'nim': nim,
      'id_periode': idperiode,
      'code_trans': CodeTransaksi,
      'nominal_id': nominal_id,
      'note': '',
      'id_emp': ''
    });
    // request.files.add(http.MultipartFile.fromBytes(
    //     'uploads', File(file.path).readAsBytesSync(),
    //     filename: file.path));
    request.files.add(await http.MultipartFile.fromBytes(
        'file_', File(file.path).readAsBytesSync(),
        filename: file.path));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  LihatBukti(String nim, String CodeTransaksi) async {
    final Map<String, dynamic> dataBody = {
      LihatBuktiM.nim: nim,
      LihatBuktiM.code_trans: CodeTransaksi,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/lihat_bukti"),
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
        var result = LihatBuktiModel.fromJson(databody);
        print(response.body);
        return result;
      }
    }
  }
}
