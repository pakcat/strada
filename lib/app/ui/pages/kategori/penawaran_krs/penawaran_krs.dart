import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/controllers/penawaran_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:sizer/sizer.dart';

class PenawaranKrsPage extends StatelessWidget {
  @override
  final box = GetStorage();

  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    String? semester;
    PenawaramKRSController controller = Get.put(PenawaramKRSController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penawaran KRS',
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
          future: controller.getmhs(data["nim"]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              semester = snapshot.data.semester;
              return FutureBuilder<dynamic>(
                  future:
                      controller.getsks(data["nim"], snapshot.data.semester),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                height: 100,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: DataColors.blusky,
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 50.w,
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
                                      "${snapshot.data.totalSks} SKS",
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
                                'Daftar Penawaran KRS',
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
                                itemCount: snapshot.data.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 100.w,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
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
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 50.w,
                                              ),
                                              child: AutoSizeText(
                                                snapshot.data.data[index].name,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data.data[index]
                                                          .bobot +
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
                                                  snapshot
                                                      .data.data[index].codeMk,
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
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "",
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
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Text(" loading");
                    }
                  });
            } else {
              return Center(child: Text("Tidak Ada Penawaran KRS Saat Ini"));
            }
          }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                if (semester == null) {
                  Get.snackbar('Hi', 'Semester Tidak Ada');
                } else {
                  controller.Submit(data["nim"], semester!, "yes");
                }
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              child: Text(
                'Terima Penawaran',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                if (semester == null) {
                  Get.snackbar('Hi', 'Semester Tidak Ada');
                } else {
                  controller.Submit(data["nim"], semester!, "no");
                }
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2.0,
                  color: Colors.red,
                ),
                primary: Colors.white, // background
                onPrimary: Colors.red, // foreground
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(14.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              child: Text(
                'Tolak Tawaran',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
