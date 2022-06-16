import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/data/models/chat_m.dart';
// import 'package:gostrada/app/routes/rout_name.dart';
import 'package:http/http.dart' as http;

// import '../data/models/absen_m.dart';
import '../data/models/test_m.dart';

class HelpdeskController extends GetxController {
  static HelpdeskController get to => Get.isRegistered<HelpdeskController>()
      ? Get.find()
      : Get.put(HelpdeskController());

  List<Message> messageList = [];

  final ScrollController scrollController = ScrollController();
  String? nimSaya;

  @override
  void onInit() {
    const oneSec = Duration(seconds: 600);
    Timer.periodic(
        oneSec, (Timer t) => nimSaya != null ? listchat(nimSaya!) : () {});
    super.onInit();
  }

  void listchat(String nim) async {
    final Map<String, dynamic> dataBody = {
      chatclass.nim: nim,
    };

    nimSaya = nim;

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/chat/get_msg"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);
      // print(DataUser['data']);
      if (databody['error'] == true) {
        //show error
      } else {
        messageList = ChatModel.fromJson(databody).data!;
      }

      update();
    }
  }

  inputchat(String nim, String pesan) async {
    final Map<String, dynamic> dataBody = {
      chatclass.nim: nim,
      chatclass.pesan: pesan,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/chat/send_msg"),
        body: dataBody);

    if (response.statusCode == 200) {
      listchat(nim);
      scrollDown();
    }
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  readpesan(String nim) async {
    final Map<String, dynamic> dataBody = {
      chatclass.nim: nim,
    };
    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/chat/read_msg"),
        body: dataBody);

    if (response.statusCode == 200) {
      listchat(nim);
    }
  }
}
