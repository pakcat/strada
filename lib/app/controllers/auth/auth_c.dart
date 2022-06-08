import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/login_m.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final box = GetStorage().obs;
  var isVisible = true.obs;
  var errorMsg = false.obs;
  late TextEditingController nimC = TextEditingController();
  late TextEditingController passC = TextEditingController();
  var isLoading = false.obs;

  // Login
  login(nim, password) async {
    isLoading.value = true;
    final Map<String, dynamic> dataBody = {
      LoginModel.username: nim,
      LoginModel.password: password,
    };

    //http request post
    var response =
        await http.post(Uri.parse(LoginModel.urlApi), body: dataBody);
    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      if (user['error'] == true) {
        // if username not match
        isLoading.value = false;
        errorMsg.value = true;
      } else {
        print(user);
        // login berhasil
        box.value.write('dataUser', {
          "username": user['nim'],
          "password": user['nim'],
          "nim": user['nim'],
          "photo": user['photo'],
          "name": user['name'],
        });
        print('login berhasil, data disimpan');
        isLoading.value = false;
        // go to dashboard page
        Get.offNamed(RoutName.root);
      }
    } else {
      Get.snackbar('Hi', 'Koneksi Error');
    }
  }

  // logout
  logout() async {
    await box.value.remove('dataUser');
    errorMsg.value = false;
    nimC.clear();
    passC.clear();
    Get.offAllNamed(RoutName.login);
  }
  // end logout

}
