import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/ui/pages/monitoring/absensikuliah.dart';
import 'package:gostrada/app/ui/pages/monitoring/lihatjadwal.dart';
import 'package:sizer/sizer.dart';
import 'package:html/parser.dart';
import '../../../controllers/monitoringC.dart';
import '../../theme/color.dart';
import 'package:intl/intl.dart';

class MonitoringPage extends StatelessWidget {
  MonitoringController controller = Get.put(MonitoringController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: DataColors.primary700,
          elevation: 0,
        ),
        body: FutureBuilder<dynamic>(
            future: controller.GetJadwalAbsensi(data["nim"]),
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
                            Text(
                              "Jadwal perkuliahan",
                              style: TextStyle(
                                  color: DataColors.primary800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            SizedBox(
                              height: 140.sp,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.jadwalKuliah.total,
                                itemBuilder: (BuildContext context, int index) {
                                  return JadwalHariIni(
                                      matkul: snapshot
                                          .data.jadwalKuliah.data[index].matkul,
                                      kelas: snapshot
                                          .data.jadwalKuliah.data[index].materi,
                                      materi: snapshot.data.jadwalKuliah
                                          .data[index].materi);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            Text(
                              "Absensi Perkuliahan",
                              style: TextStyle(
                                  color: DataColors.primary800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.absensi.total,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.sp, vertical: 12.sp),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.sp),
                                          border: Border.all(
                                              color: DataColors.primary200)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.absensi.data[index]
                                                  .matkul,
                                              style: TextStyle(
                                                  color: DataColors.primary800,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp),
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Text(
                                              "${DateFormat('EEEE, d MMM yyyy', "id_ID").format(snapshot.data.absensi.data[index].date)} \n ${snapshot.data.absensi.data[index].startTime} - ${snapshot.data.absensi.data[index].endTime}",
                                              style: TextStyle(
                                                  color: DataColors.Neutral400,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(AbsensiKuliahPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(4.sp),
                                                  decoration: BoxDecoration(
                                                      color: DataColors.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.sp)),
                                                  child: const Text(
                                                    "Submit Kehadiran",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ]),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Belum ada data monitoring",
                        style: TextStyle(color: DataColors.primary400),
                      ),
                    );
                  }
              }
            }));
  }
}

class JadwalHariIni extends StatelessWidget {
  final String matkul;
  final String kelas;
  final String materi;
  const JadwalHariIni({
    Key? key,
    required this.matkul,
    required this.kelas,
    required this.materi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200.sp,
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: DataColors.primary100,
            borderRadius: BorderRadius.circular(8.sp)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 200.sp,
            child: Text(
              matkul,
              overflow: TextOverflow.ellipsis,
              style: (TextStyle(
                  fontSize: 11.sp,
                  color: DataColors.primary,
                  fontWeight: FontWeight.w600)),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.sp),
              padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 2.sp),
              decoration: BoxDecoration(
                  color: DataColors.primary400,
                  borderRadius: BorderRadius.circular(2.sp)),
              child: Text(
                kelas,
                style: TextStyle(fontSize: 13.sp, color: Colors.white),
              )),
          Text(materi,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: DataColors.primary700,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 15.sp,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Get.to(JadwalKuliahPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
                decoration: BoxDecoration(
                    color: DataColors.primary,
                    borderRadius: BorderRadius.circular(2.sp)),
                child: const Text("Lihat Jadwal",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

//here goes the function
