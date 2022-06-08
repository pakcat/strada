import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/masterkrs_m.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController{
  final box = GetStorage();
  late Map data = box.read("dataUser") as Map<String, dynamic>;
  final String urlPhoto = 'https://sia.iik-strada.ac.id/uploads/mhs/';
  final String masterKRS =
      'https://sia.iik-strada.ac.id/mobile/Data/master_krs';

  var dataMasterKrs;
  var isLoading = true.obs;
  var user;
  

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    final Map<String, dynamic> dataBody = {
      "nim": data['nim'],
    };

    //http request post
    var response = await http.post(Uri.parse(masterKRS), body: dataBody);
    if (response.statusCode == 200) {
      user = jsonDecode(response.body);
      if (user['error'] == true) {
        //
      } else {
        // load berhasil
        dataMasterKrs = MasterKrsModel.fromJson(jsonDecode(response.body));
        print('load master krs berhasil');
        print(user);
      }
      isLoading.value = false;
    }
  }

}