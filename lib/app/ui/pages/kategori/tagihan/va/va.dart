import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/tagihan_c.dart';
import '../../../../theme/color.dart';

class VAPage extends StatefulWidget {
  @override
  State<VAPage> createState() => _VAPageState();
}

class _VAPageState extends State<VAPage> {
  @override
  TagihanController controller = Get.put(TagihanController());

  final box = GetStorage();

  String? VA;

  Widget build(BuildContext context) {
    final now = new DateTime.now();
    final expired = now.add(Duration(hours: 2));
    var array = Get.arguments;
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Virtual Account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: DataColors.primary700,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                    Icons.arrow_back_ios), // Put icon of your preference.
                onPressed: () {
                  Get.back();
                },
              );
            },
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.sp),
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Virtual Account",
                        style: TextStyle(
                            color: DataColors.primary800,
                            fontWeight: FontWeight.w400),
                      ),
                      FutureBuilder<dynamic>(
                          future: controller.getva(
                              data['nim'].toString(),
                              array[1].toString(),
                              "pembayaran online",
                              array[0].toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              box.write('va', snapshot.data.virtualAccount);
                              box.write('nominal', array[1]);
                              VA = snapshot.data.virtualAccount;
                              return Text(snapshot.data.virtualAccount,
                                  style: TextStyle(
                                      color: DataColors.primary800,
                                      fontWeight: FontWeight.w600));
                            } else {
                              return (box.read('va') == null)
                                  ? Text("Mohon Tunggu 2 Jam Lagi")
                                  : Text(box.read('va'),
                                      style: TextStyle(
                                          color: DataColors.primary800,
                                          fontWeight: FontWeight.w600));
                            }
                          })
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: box.read('va')));
                      Get.snackbar('Hi', 'VA berhasil dicopy');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "SALIN",
                        style: TextStyle(
                            color: DataColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Pembayaran",
                      style: TextStyle(
                          color: DataColors.primary800,
                          fontWeight: FontWeight.w400)),
                  Text(
                      (box.read('nominal') == null)
                          ? array[1].toString()
                          : box.read('nominal'),
                      style: TextStyle(
                          color: DataColors.primary800,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.sp, bottom: 15.sp),
              height: 20.sp,
              width: 100.w,
              color: DataColors.Neutral100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
              child: Text("Batas Akhir Pembayaran",
                  style: TextStyle(
                      color: DataColors.Neutral400,
                      fontWeight: FontWeight.w400)),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kamis, 20 Jun 2022 15:30 WIB",
                      style: TextStyle(
                          color: DataColors.primary900,
                          fontWeight: FontWeight.w600)),
                  Text("23:59:52",
                      style: TextStyle(
                          color: HexColor("#C5694D"),
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Text(
                  "Nomor Virtual Account Bank akan terhapus apabila anda tidak membayar dalam jangka waktu 2 x 24 jam.",
                  style: TextStyle(
                      color: DataColors.Neutral400,
                      fontWeight: FontWeight.w400)),
            )
          ]),
        ));
  }
}
