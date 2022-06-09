import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/bankmodel.dart';
import 'package:gostrada/app/data/models/tagihan_m.dart';
import 'package:http/http.dart' as http;

import '../data/models/test_m.dart';
import '../ui/pages/kategori/tagihan/va/preview_pembayaran.dart';

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
        print(response.body);

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
    final Map<String, dynamic> dataBody = {
      BuatTagihan.nim: nim,
      BuatTagihan.id_biaya: id_biaya,
      BuatTagihan.id_credit: id_credit,
      BuatTagihan.bayar: bayar,
    };
    print("id_biaya $id_biaya");
    print("id_credit $id_credit");
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/save_tagihan"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        print(response.body);
        return null;
      } else {
        var result = SaveTagihanModel.fromJson(databody);
        Get.snackbar('Hi', 'Tagihan Berhasil Disimpan');
        print(result.codeTrans);
        Get.to(PreviewPembayaranPage(),
            arguments: [result.codeTrans, totaltagihan]);
      }
    }
  }

  getva(
      String nim, String total_payment, String name, String code_trans) async {
    final Map<String, dynamic> dataBody = {
      CodeVA.nim: nim,
      CodeVA.total_payment: total_payment,
      CodeVA.name: name,
      CodeVA.code_trans: code_trans,
    };
    print(nim);
    print(total_payment);
    print(name);
    print(code_trans);
    var response = await http.post(
        Uri.parse(
            "https://sia.iik-strada.ac.id/mobile/payment/create_ecollection"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        print(response.body);
        return null;
      } else {
        var result = CodeVaModel.fromJson(databody);
        print(response.body);
        return result;
      }
    }
  }

  DataBank() async {
    var response = await http.get(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/get_bank"));

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);

      if (databody['error'] == true) {
        //show error
        print(response.body);
        return null;
      } else {
        var result = BankModel.fromJson(databody);
        print(response.body);
        return result;
      }
    }
  }
}
