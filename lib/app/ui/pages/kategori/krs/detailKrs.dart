import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/krs/detailKrs_c.dart';
import 'package:gostrada/app/controllers/krs/krs_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';

class DetailKRSPage extends StatelessWidget {
  final x = Get.put(DetailKrsController());
  KrsController c = Get.put(KrsController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => x.loadDetailKrs.isTrue
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
                title: Text('Detail KRS'),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        height: 100,
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
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: size.width / 2,
                              ),
                              child: AutoSizeText(
                                "Total SKS yang diambil",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: DataColors.primary700,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              x.totalSks.toString() + " SKS",
                              style: TextStyle(
                                fontSize: 20,
                                color: DataColors.primary700,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Daftar KRS',
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
                        itemCount: x.dataDetailKrs.length,
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
                                        x.dataDetailKrs[index]['name'],
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
                                          x.dataDetailKrs[index]['bobot'] +
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
                                              x.dataDetailKrs[index]['code_mk'],
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
                                Column(
                                  children: [
                                    Text(
                                      'Kelas',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: DataColors.primary700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
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
                                          "G",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
                  onPressed: () => x.downloadFile(),
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
                    'Unduh KRS',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
    );
  }
}
