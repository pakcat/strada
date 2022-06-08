import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../theme/color.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Heri Saputro, S.Kep., Ns., M.Kep.',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        backgroundColor: Colors.white,
        foregroundColor: DataColors.primary,
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
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10.sp,
                width: 10.sp,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: HexColor("#66C155")),
              ),
              SizedBox(
                width: 5.sp,
              ),
              Text("Online")
            ],
          ),
          SizedBox(height: 20.sp),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20.0.sp, bottom: 10.sp),
              child: Container(
                width: 50.w,
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    color: DataColors.primary200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Column(
                  children: [
                    Text(
                      "Selamat pagi pak, mohon maaf mengganggu sebelumnya",
                      style: TextStyle(
                          color: DataColors.primary600, fontSize: 10.sp),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("10.20",
                          style: TextStyle(
                              color: DataColors.primary, fontSize: 10.sp)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0.sp, bottom: 10.sp),
              child: Container(
                width: 50.w,
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    color: DataColors.Neutral200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Column(
                  children: [
                    Text(
                      "Ada yang bisa saya bantu?",
                      style: TextStyle(
                          color: DataColors.primary600, fontSize: 10.sp),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("10.20",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: DataColors.primary, fontSize: 10.sp)),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.sp, horizontal: 12.sp),
        child: TextField(
          style: TextStyle(fontSize: 12.sp),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: DataColors.primary700,
                ),
              ),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.attach_file),
                color: DataColors.primary400,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.sp),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              filled: true,
              fillColor: DataColors.Neutral100),
        ),
      ),
    );
  }
}
