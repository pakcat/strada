import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/khs/khs_c.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';

class KhsPage extends StatelessWidget {
  final c = Get.put(KHSController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => c.isLoading.isTrue
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
                titleSpacing: 0,
                title: Text(
                  'Data KHS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: DataColors.primary700,
                  ),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: GetBuilder<KHSController>(
                    builder: (cont) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'KHS Terakhir',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: DataColors.primary700,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // box info khs terakhir

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 143,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: DataColors.blusky,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 20,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: SvgPicture.asset(
                                      'assets/images/khs/khs.svg',
                                      height: 140,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '2021/2022',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DataColors.primary700,
                                            ),
                                          ),
                                          Text(
                                            'GASAL',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: DataColors.primary700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "(Semester 3)",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: HexColor('#3C5595'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '3.45/4.00',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: DataColors.primary700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              'INDEKS PRESTASI SEMESTER',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: DataColors.skyBlue,
                                                  letterSpacing: 1.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          // end box info khs Aktif

                          SizedBox(
                            height: 30,
                          ),

                          //detail periode dan semester
                          Text(
                            'Periode dan semester',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: DataColors.primary700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: c.dataMasterKhs.semester['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  cont.semester = c.dataMasterKhs
                                      .semester['data'][index]['semester'];
                                  cont.nim = c.dataMasterKhs.nim;
                                  Get.toNamed(RoutName.detailkhs);
                                },
                                child: Container(
                                  height: 120,
                                  width: size.width,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '2020/2021',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: DataColors.primary700,
                                                ),
                                              ),
                                              Text(
                                                int.parse(c.dataMasterKhs.semester[
                                                                        'data']
                                                                    [index]
                                                                ['semester']) %
                                                            2 ==
                                                        0
                                                    ? 'GENAP'
                                                    : "GASAL",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: DataColors.primary700,
                                                ),
                                              ),
                                              Text(
                                                "(Semester  " +
                                                    c.dataMasterKhs
                                                            .semester['data']
                                                        [index]['semester'] +
                                                    ")",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: HexColor('#3C5595'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '3.45/4.00',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: DataColors.primary700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: Text(
                                                  'INDEKS PRESTASI SEMESTER',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DataColors.skyBlue,
                                                      letterSpacing: 1.0),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
