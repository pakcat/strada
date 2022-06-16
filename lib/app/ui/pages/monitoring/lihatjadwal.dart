import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/controllers/monitoringC.dart';
import 'package:sizer/sizer.dart';

import '../../theme/color.dart';

class JadwalKuliahPage extends StatelessWidget {
  final box = GetStorage();
  MonitoringController controller = Get.put(MonitoringController());
  @override
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agenda Kegiatan',
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
          future: controller.GetDetailJadwal(data["nim"]),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            itemCount: snapshot.data.data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.data[i].tahun,
                                    style: TextStyle(
                                        color: DataColors.primary800,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  ListView.builder(
                                    itemCount:
                                        snapshot.data.data[i].data.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (BuildContext context, int j) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 15.sp),
                                        child: SizedBox(
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemCount: snapshot.data.data[i]
                                                  .data[j].data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int k) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.sp,
                                                                horizontal:
                                                                    5.sp),
                                                        decoration: BoxDecoration(
                                                            color: DataColors
                                                                .primary100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.sp)),
                                                        child: Text(
                                                            snapshot
                                                                .data
                                                                .data[i]
                                                                .data[j]
                                                                .data[k]
                                                                .labelTanggal,
                                                            style: TextStyle(
                                                                color: DataColors
                                                                    .primary800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    13.sp)),
                                                      ),
                                                    ),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      flex: 10,
                                                      child: ListView.builder(
                                                        itemCount: snapshot
                                                            .data
                                                            .data[i]
                                                            .data[j]
                                                            .data[k]
                                                            .data
                                                            .length,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const ScrollPhysics(),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int l) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        10.sp),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.sp,
                                                                      vertical:
                                                                          15.sp),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: DataColors
                                                                          .primary200),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.sp)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${snapshot.data.data[i].data[j].data[k].data[l].matkul} \n(${snapshot.data.data[i].data[j].data[k].data[l].materi})",
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10.sp,
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data
                                                                        .data[i]
                                                                        .data[j]
                                                                        .data[k]
                                                                        .data[l]
                                                                        .materi,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        color: DataColors
                                                                            .Neutral300),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Tidak Ada Jadwal",
                      style: TextStyle(color: DataColors.primary600),
                    ),
                  );
                }
            }
          }),
    );
  }
}
