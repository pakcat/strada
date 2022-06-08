import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/khs/detailKhs_c.dart';
import 'package:gostrada/app/controllers/khs/khs_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailKhsPage extends StatelessWidget {
  final x = Get.put(DetailKhsController());
  KHSController c = Get.put(KHSController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => x.loadDetailKhs.isTrue
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(DataColors.primary700),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Detail KHS'),
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
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Semester " + c.semester,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: DataColors.primary700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        width: size.width,
                        decoration: BoxDecoration(
                          color: DataColors.blusky,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  x.ips,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: DataColors.primary700,
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width / 4,
                                  ),
                                  child: AutoSizeText(
                                    'Indeks Prestasi Semester',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor('#7D98CE'),
                                    ),
                                  ),
                                ),
                                Text(
                                  '(IPS)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor('#7D98CE'),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black26,
                              height: 80,
                              width: 1,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  x.ipk,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: DataColors.primary700,
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width / 4,
                                  ),
                                  child: AutoSizeText(
                                    'Indeks Prestasi Kumulatif',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor('#7D98CE'),
                                    ),
                                  ),
                                ),
                                Text(
                                  '(IPK)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor('#7D98CE'),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.black26,
                              height: 80,
                              width: 1,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    x.totalSks.toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: DataColors.primary700,
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width / 4,
                                    ),
                                    child: AutoSizeText(
                                      'Jumlah SKS Semester Ini',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor('#7D98CE'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Daftar KHS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: DataColors.primary700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: x.dataDetailKhs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: size.width / 2,
                                      ),
                                      child: AutoSizeText(
                                        x.dataDetailKhs[index]['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: DataColors.primary700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          x.dataDetailKhs[index]['bobot'] +
                                              " SKS",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: DataColors.primary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Kode: " +
                                              x.dataDetailKhs[index]['code_mk'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: DataColors.primary,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  // padding: EdgeInsets.all(5),
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: DataColors.primary700,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      x.dataDetailKhs[index]['nilai'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {},
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
                    'Unduh KHS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
    );
  }
}
