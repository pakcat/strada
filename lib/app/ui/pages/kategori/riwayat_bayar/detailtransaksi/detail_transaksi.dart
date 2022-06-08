import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/keuangan/detailtransaksi.dart';
import '../../../../../controllers/riwayatbayar_C.dart';

class DetailTransaksi extends StatelessWidget {
  bool vis = false;
  var i = Get.arguments;
  final box = GetStorage();
  RiwayatBayarController c = Get.put(RiwayatBayarController());
  @override
  DetailTransaksiController controller = Get.put(DetailTransaksiController());
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Transaksi',
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
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HexColor("#B6B6B6"), width: 1.sp)),
            // child: FutureBuilder(
            //   future: c.RB(data['nim']),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     c.codepembayaran = c.data[0].data![i].codeTrans;
            //     return Container();
            //   },
            // ),
            child: FutureBuilder<dynamic>(
                future: c.RB(data['nim']),
                builder: (context, snapshot) {
                  c.codepembayaran = c.data[0].data![i].codeTrans;
                  c.UnduhBuktiBayar(c.codepembayaran);
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.sp,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: DataColors.primary800,
                                size: 100,
                              ),
                              Text(
                                "Telah Dikonfirmasi",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: DataColors.primary800,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Text(
                                  "${DateFormat('dd MMMM yyyy').format(snapshot.data.data[i].dibuat)} | ${DateFormat('Hm').format(snapshot.data.data[i].dibuat)}",
                                  style: TextStyle(
                                      color: DataColors.Neutral300,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp)),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Text(
                                  "Kode transaksi : ${snapshot.data.data[i].codeTrans}",
                                  style: TextStyle(
                                      color: HexColor("#757575"),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.sp)),
                              SizedBox(
                                height: 5.sp,
                              ),
                            ],
                          ),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 6.0,
                          dashColor: HexColor("#DADADA"),
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Informasi",
                                      style: TextStyle(
                                          color: DataColors.primary700,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp)),
                                  IconButton(
                                      onPressed: () {
                                        vis = controller.onclick(vis);
                                      },
                                      icon: Icon(Icons.arrow_drop_down))
                                ],
                              ),
                              GetBuilder<DetailTransaksiController>(
                                init: DetailTransaksiController(),
                                initState: (_) {},
                                builder: (_) {
                                  return Visibility(
                                    visible: vis,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "NIM",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(snapshot.data.data[i].nim,
                                                style: TextStyle(
                                                    color:
                                                        DataColors.primary900,
                                                    fontSize: 10.sp)),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Nama Mahasiswa",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(snapshot.data.data[i].namaMhs,
                                                style: TextStyle(
                                                    color:
                                                        DataColors.primary900,
                                                    fontSize: 10.sp)),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Periode Ajaran",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                                snapshot
                                                    .data.data[i].periodeAjaran,
                                                style: TextStyle(
                                                    color:
                                                        DataColors.primary900,
                                                    fontSize: 10.sp)),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Fakultas",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  snapshot
                                                      .data.data[i].fakultas,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp)),
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Program Studi",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(snapshot.data.data[i].prodi,
                                                style: TextStyle(
                                                    color:
                                                        DataColors.primary900,
                                                    fontSize: 10.sp)),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Tanggal Cetak",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                                "${DateFormat('dd-mm-yyyy').format(snapshot.data.data[i].dibuat)}",
                                                style: TextStyle(
                                                    color:
                                                        DataColors.primary900,
                                                    fontSize: 10.sp)),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 6.0,
                          dashColor: HexColor("#DADADA"),
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("TOTAL TAGIHAN",
                                  style: TextStyle(
                                      color: DataColors.primary600,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.sp)),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("nominal",
                                      style: TextStyle(
                                          color: DataColors.primary900,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp)),
                                  Text(snapshot.data.data[i].nominal,
                                      style: TextStyle(
                                          color: DataColors.primary600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp))
                                ],
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: Text("Tidak Ada Data"));
                  }
                }),
          )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () async {
            final dir = await getExternalStorageDirectory();
            final directory = await getTemporaryDirectory();
            c.download(
                Dio(), c.codepembayaran, dir!.path + "_BuktiPembayaran.pdf");
            //c.Unduh(directory.path + "hai.pdf");
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
            'Unduh Bukti',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
