import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../theme/color.dart';

class InformasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: DataColors.primary700,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Agenda Hari Ini",
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
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return JadwalHariIni();
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "Agenda Mendatang",
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
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return JadwalHariIni();
                },
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "Absensi",
              style: TextStyle(
                  color: DataColors.primary800,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp),
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(color: DataColors.primary200)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ilmu Kesehatan Masyarakat",
                              style: TextStyle(
                                  color: DataColors.primary800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              "Senin, 13 Juni 2022 \n 8.40-10.20 WIB",
                              style: TextStyle(
                                  color: DataColors.Neutral400,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(4.sp),
                                  decoration: BoxDecoration(
                                      color: DataColors.primary,
                                      borderRadius:
                                          BorderRadius.circular(5.sp)),
                                  child: Text(
                                    "Submit Kehadiran",
                                    style: TextStyle(color: Colors.white),
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
        ));
  }
}

class JadwalHariIni extends StatelessWidget {
  const JadwalHariIni({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: DataColors.primary100,
            borderRadius: BorderRadius.circular(8.sp)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Ilmu Kesehatan Masyarakat",
            style: (TextStyle(
                fontSize: 11.sp,
                color: DataColors.primary,
                fontWeight: FontWeight.w600)),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.sp),
              padding: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 2.sp),
              decoration: BoxDecoration(
                  color: DataColors.primary400,
                  borderRadius: BorderRadius.circular(2.sp)),
              child: Text(
                "MEETING 12",
                style: TextStyle(fontSize: 13.sp, color: Colors.white),
              )),
          Text("Gizi Kesehatan Masyarakat",
              style: TextStyle(
                  fontSize: 12.sp,
                  color: DataColors.primary700,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 15.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 100.sp),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 2.sp),
                decoration: BoxDecoration(
                    color: DataColors.primary,
                    borderRadius: BorderRadius.circular(2.sp)),
                child:
                    Text("Lihat Jadwal", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
