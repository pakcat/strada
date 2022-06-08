import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/controllers/tagihan_c.dart';
import 'package:gostrada/app/data/models/tagihan_m.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/jenistagihan.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/semuatagihan.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class TagihanPage extends StatelessWidget {
  final box = GetStorage();
  TagihanController controller = Get.put(TagihanController());
  @override
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tagihan',
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
      body: FutureBuilder<dynamic>(
          future: controller.Tagihan(data['nim']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 14.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: DataColors.blusky),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.asset(
                              'assets/images/dashboard/icon/tagihan.svg',
                              color: DataColors.primary.withOpacity(0.20),
                              height: 70.sp,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Tagihan:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: DataColors.primary700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data.namaTagihan,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: DataColors.primary,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tagihan Cicilan",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: DataColors.primary800,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (snapshot.data.tagihanCicilan.contentCicilan != 0)
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 150.sp, minHeight: 10.sp),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.tagihanCicilan.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return tagihancicilan(
                                    nama: snapshot
                                        .data.tagihanCicilan.data[index].nama,
                                    nominal: snapshot.data.tagihanCicilan
                                        .data[index].nominal,
                                    total: snapshot
                                        .data.tagihanCicilan.data[index].total,
                                    terbayar: snapshot.data.tagihanCicilan
                                        .data[index].terbayar);
                              },
                            ),
                          )
                        : tidakadatagihan(),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tagihan Semester",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: DataColors.primary800,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (snapshot.data.tagihanSemester.contentTagihan != 0)
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 150.sp, minHeight: 10.sp),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.tagihanSemester.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return tagihansemester(
                                    semester: snapshot.data.tagihanSemester
                                        .data[index].semester,
                                    nominal: snapshot.data.tagihanSemester
                                        .data[index].nominal,
                                    total: snapshot
                                        .data.tagihanSemester.data[index].total,
                                    terbayar: snapshot.data.tagihanSemester
                                        .data[index].terbayar);
                              },
                            ),
                          )
                        : tidakadatagihan(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tagihan Sedang Aktif",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: DataColors.primary800,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (snapshot.data.tagihanActive.activeTagihan != 0)
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 170.sp, minHeight: 10.sp),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.tagihanActive.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return TagihanExpired(
                                    codeTrans: snapshot.data.tagihanActive
                                        .data[index].codeTrans,
                                    nominal: snapshot
                                        .data.tagihanActive.data[index].nominal,
                                    tanggaldibuat: snapshot.data.tagihanActive
                                        .data[index].tanggalDibuat,
                                    tanggalexpired: snapshot.data.tagihanActive
                                        .data[index].tanggalExpired);
                              },
                            ),
                          )
                        : tidakadatagihan(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tagihan Telah Expired",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: DataColors.primary800,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (snapshot.data.tagihanExpired.tagihanExpired != 0)
                        ? ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 170.sp, minHeight: 10.sp),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.tagihanExpired.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return TagihanExpired(
                                    codeTrans: snapshot.data.tagihanExpired
                                        .data[index].codeTrans,
                                    nominal: snapshot.data.tagihanExpired
                                        .data[index].nominal,
                                    tanggaldibuat: snapshot.data.tagihanExpired
                                        .data[index].tanggalDibuat,
                                    tanggalexpired: snapshot.data.tagihanExpired
                                        .data[index].tanggalExpired);
                              },
                            ),
                          )
                        : tidakadatagihan(),
                    //TagihanExpired()
                  ],
                ),
              );
            } else {
              return Center(child: Text("Tidak Ada Data"));
            }
          }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(bottom: 20, top: 20),
        child: ElevatedButton(
          onPressed: () {
            Get.to(SemuaTagihanPage());
          },
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 2.0,
              color: DataColors.primary,
            ),
            primary: Colors.white, // background
            onPrimary: DataColors.primary700, // foreground
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(14.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          child: Text(
            'Buat Tagihan',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class tidakadatagihan extends StatelessWidget {
  const tidakadatagihan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: DataColors.blusky),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/images/tagihan/info.svg',
            color: DataColors.primary.withOpacity(0.50),
            height: 70.sp,
          ),
          Text(
            "Tidak Ada Tagihan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: DataColors.primary800,
            ),
          )
        ],
      ),
    );
  }
}

class tagihancicilan extends StatelessWidget {
  final String nama;
  final int nominal;
  final int total;
  final int terbayar;
  const tagihancicilan({
    Key? key,
    required this.nama,
    required this.nominal,
    required this.total,
    required this.terbayar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Padding(
      padding: EdgeInsets.only(right: 8.0.sp),
      child: Container(
        height: 150.sp,
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 14.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: DataColors.blusky),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: DataColors.primary400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formatCurrency.format(nominal),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: DataColors.primary800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: DataColors.backgroundbutton),
                  child: Text(
                    "total: ${formatCurrency.format(total)}",
                    style: TextStyle(
                        color: DataColors.blusky,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: DataColors.backgroundbutton),
                  child: Text(
                    "telah dibayar: ${formatCurrency.format(terbayar)}",
                    style: TextStyle(
                        color: DataColors.blusky,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TagihanExpired extends StatelessWidget {
  final String codeTrans;
  final int nominal;
  final String tanggaldibuat;
  final String tanggalexpired;

  const TagihanExpired({
    Key? key,
    required this.codeTrans,
    required this.nominal,
    required this.tanggaldibuat,
    required this.tanggalexpired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: DataColors.blusky),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: HexColor("#C3D8F6")),
                child: Text(
                  "TAGIHAN NO $codeTrans",
                  style: TextStyle(
                      color: DataColors.primary700,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                formatCurrency.format(nominal),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: DataColors.primary800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: DataColors.primary400),
                child: Text(
                  "tanggal dibuat: $tanggaldibuat",
                  style: TextStyle(
                      color: DataColors.blusky,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: DataColors.primary800),
                child: Text(
                  "tanggal expired: $tanggalexpired",
                  style: TextStyle(
                      color: DataColors.blusky,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ]),
      ),
    );
  }
}

class tagihansemester extends StatelessWidget {
  final int semester;
  final int nominal;
  final int total;
  final int terbayar;
  const tagihansemester({
    Key? key,
    required this.semester,
    required this.nominal,
    required this.total,
    required this.terbayar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Padding(
      padding: EdgeInsets.only(right: 8.0.sp),
      child: Container(
        height: 150.sp,
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 14.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: DataColors.blusky),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Semester ${semester.toString()}",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: DataColors.primary400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formatCurrency.format(nominal),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: DataColors.primary800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: DataColors.backgroundbutton),
                  child: Text(
                    "total: ${formatCurrency.format(total)}",
                    style: TextStyle(
                        color: DataColors.blusky,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: DataColors.backgroundbutton),
                  child: Text(
                    "telah dibayar: ${formatCurrency.format(terbayar)}",
                    style: TextStyle(
                        color: DataColors.blusky,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
