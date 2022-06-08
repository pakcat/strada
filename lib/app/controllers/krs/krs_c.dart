import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/data/models/masterkrs_m.dart';
import 'package:http/http.dart' as http;

class KrsController extends GetxController {
  final box = GetStorage();
  late Map data = box.read("dataUser") as Map<String, dynamic>;
  final String masterKRS =
      'https://sia.iik-strada.ac.id/mobile/Data/master_krs';
  
  var dataMasterKrs;
  var isLoading = true.obs;
  var loaderVisible = false.obs;
  var semester = "0";
  var nim = "0";
  
  
  
  
  

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
      var user = jsonDecode(response.body);
      if (user['error'] == true) {
        //
      } else {
        // load berhasil
        dataMasterKrs = MasterKrsModel.fromJson(jsonDecode(response.body));
        print('load master krs berhasil');
      }
      isLoading.value = false;
    }
  }

 

  // downloadFile() async {
  //   final Map<String, dynamic> dataBody = {
  //     "semester_value": "1",
  //     "nim_value": "2151B1070",
  //   };
  //   Dio dio = Dio();
  //   var response = await dio.post("https://sia.iik-strada.ac.id/mhs_krs/download_krs",
  //     options: Options(
  //       headers: {"Accept": "application/json"},
  //       // method: 'POST',
  //       followRedirects: false,
  //       validateStatus: (status) { return status! < 500; }
        
  //     ),
  //     data: dataBody,
  //   );

  //   print(response.statusCode);
  // }
}
