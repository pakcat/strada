import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/transkrip/transkrip_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class TranskripPage extends StatelessWidget {
  final x = Get.put(TranskripController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transkrip Nilai',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DataColors.primary700,
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: size.width,
                decoration: BoxDecoration(
                  color: DataColors.blusky,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2), // changes position of shadow
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
                          "36",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: DataColors.primary700,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 100.w / 4,
                          ),
                          child: AutoSizeText(
                            'Total SKS yang diambil',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#7D98CE'),
                            ),
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
                      margin: const EdgeInsets.only(left: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "3.73",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: DataColors.primary700,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 100.w / 4,
                            ),
                            child: AutoSizeText(
                              'Indeks Prestasi Kumulaitif (IPK)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700,
                                color: HexColor('#7D98CE'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black26,
                      height: 80,
                      width: 1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Cumlaude",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: DataColors.primary700,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 100.w / 4,
                          ),
                          child: AutoSizeText(
                            'Prestasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#7D98CE'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: x.transkripNilai.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.black26,
                          height: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Semester  ' + x.transkripNilai[index]['semester'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: DataColors.primary700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black26,
                          height: 20,
                        ),
                        ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: x.result['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: size.width / 2,
                                          ),
                                          child: AutoSizeText(
                                            x.result['data'][index]['name'],
                                            // x.transkripNilai[index]['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: DataColors.primary700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      // padding: EdgeInsets.all(5),
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: DataColors.primary700,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          x.result['data'][index]['nilai'],
                                          style: const TextStyle(
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
                            }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        margin: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 2.0,
              color: DataColors.primary,
            ),
            primary: Colors.white, // background
            onPrimary: DataColors.primary700, // foreground
            shape: RoundedRectangleBorder(
              // ignore: unnecessary_new
              borderRadius: new BorderRadius.circular(14.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          child: const Text(
            'Unduh Transkrip',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        // ),
      ),
    );
  }
}
