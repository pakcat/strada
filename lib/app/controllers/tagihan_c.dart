import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/tagihan_m.dart';
import 'package:http/http.dart' as http;

import '../data/models/test_m.dart';

class TagihanController extends GetxController {
  RxInt totaltagihan = 0.obs;
  RxInt sisa = 0.obs;
  List<String> id = [];
  List<String> name = [];
  List<BuatTagihanModel> data = [];
  List<dynamic> datadatum = [];
  int total = 0;
  List<bool> isVisible = [];
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllers2 = [];

  toggle(bool isVisible) {
    isVisible = !isVisible;

    update();
    return isVisible;
  }

  Tagihan(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/tagihan"),
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
        var result = TagihanModel.fromJson(databody);
        print(response.body);
        return result;
      }
    }
  }

  getcredit(nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/select_credit"),
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
        var result = GetCreditModel.fromJson(databody);
        id.clear();
        name.clear();
        for (var item in result.data) {
          id.add(item.id);
        }
        for (var item in result.data) {
          name.add(item.name);
        }
        return result;
      }
    }
  }

  loadtagihan(nim, credit_id) async {
    final Map<String, dynamic> dataBody = {
      TagihanMo.nim: nim,
      TagihanMo.credit_id: credit_id,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/buat_tagihan"),
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
        var result = BuatTagihanModel.fromJson(databody);
        if (result.data![0].idCredit == 0) {
          return;
        }
        int idx = data.indexWhere(
            (element) => element.data![0].idCredit == result.data![0].idCredit);
        if (idx < 0) {
          data.add(result);
          totaltagihan.value += result.data![0].nominal;

          controllers.add(TextEditingController(
              text: (result.data![0].nominal).toString()));
          controllers2.add(TextEditingController());
          isVisible.add(false);

          update();

          //print(data[idx - 1].data[0].nominal);
        }
        print(response.body);

        return result;
      }
    }
  }

  loadsemuatagihan(nim) async {
    final Map<String, dynamic> dataBody = {
      TagihanMo.nim: nim,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/buat_tagihan"),
        body: dataBody);
    print(nim);
    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        totaltagihan.value = 0;
        var result = BuatTagihanModel.fromJson(databody);
        for (var i = 0; i < result.data!.length; i++) {
          totaltagihan.value += result.data![i].nominal;
        }
        data.clear();
        datadatum.clear();
        data.add(result);
        for (var i = 0; i < result.data!.length; i++) {
          datadatum.add(result.data![i]);
        }
        for (var i = 0; i < result.data!.length; i++) {
          controllers.add(
              TextEditingController(text: (datadatum[i].nominal).toString()));
          controllers2.add(TextEditingController());
        }

        print(data[0].data!.length);
        print(result.data!.length);

        update();
        return result;
      }
    }
  }

  resetTotal() {
    totaltagihan.value = 0;
    update();
  }

  confirmtagihan(nim, id_biaya, id_credit, bayar) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://sia.iik-strada.ac.id/mobile/keuangan/save_tagihan'));
    request.fields.addAll({
      'nim': nim,
      'id_biaya': id_biaya,
      'id_credit': id_credit,
      'bayar': bayar
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // var databody = jsonDecode(await response.stream.bytesToString());
      //var result = SaveTagihanModel.fromJson(databody);

      print(await response.stream.bytesToString());
      Get.snackbar('Hi', 'Tagihan Berhasil Disimpan');
      //Get.snackbar('${result.pesan}', "${result.codeTrans}");
    } else {
      print(response.reasonPhrase);
    }
  }
}
