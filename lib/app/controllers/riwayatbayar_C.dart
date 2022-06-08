import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/data/models/test_m.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../data/models/riwayatbayar_m.dart';

class RiwayatBayarController extends GetxController {
  double progress = 0;
  List<UnduhBuktiModel> link = [];
  String? codepembayaran;
  List<RiwayatBayar> data = [];
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      directory = Directory('/storage/emulated/0/Download');
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  RB(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };
    print("ini test");
    var response = await http.post(
        Uri.parse(
            "https://sia.iik-strada.ac.id/mobile/keuangan/riwayat_pembayaran"),
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
        data.clear();
        var result = RiwayatBayar.fromJson(databody);
        print("ini");
        print(response.body);
        data.add(result);

        return result;
      }
    }
  }

  UnduhBuktiBayar(String? code) async {
    final Map<String, dynamic> dataBody = {
      UnduhBukti.code: code,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/print_invc"),
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
        var result = UnduhBuktiModel.fromJson(databody);
        // final taskId = await FlutterDownloader.enqueue(
        //   url: result.file,
        //   savedDir: '/storage/emulated/0/Download/',
        //   showNotification:
        //       true, // show download progress in status bar (for Android)
        //   openFileFromNotification:
        //       true, // click on notification to open downloaded file (for Android)
        // );
        link.clear();
        link.add(result);
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future download(Dio dio, String? code, String place) async {
    final Map<String, dynamic> dataBody = {
      UnduhBukti.code: code,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/keuangan/print_invc"),
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
        var result = UnduhBuktiModel.fromJson(databody);
        print(place);
        print(result.file);
        // final taskId = await FlutterDownloader.enqueue(
        //   url: result.file,
        //   savedDir: '/storage/emulated/0/Download/',
        //   showNotification:
        //       true, // show download progress in status bar (for Android)
        //   openFileFromNotification:
        //       true, // click on notification to open downloaded file (for Android)
        // );
        try {
          var response = await dio.get(
            result.file,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }),
          );
          var file = File(place).openSync(mode: FileMode.write);
          file.writeFromSync(response.data);
          await file.close();

          //Pspdfkit.present(place);
          // Here, you're catching an error and printing it. For production
          // apps, you should display the warning to the user and give them a
          // way to restart the download.
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
