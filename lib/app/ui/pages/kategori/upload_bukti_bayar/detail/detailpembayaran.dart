import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/ui/pages/kategori/upload_bukti_bayar/detail/lihatbukti.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/keuangan/detailtransaksi.dart';
import '../../../../../controllers/uploadbuktip_c.dart';

class DetailPembayaran extends StatelessWidget {
  final box = GetStorage();
  var index = Get.arguments;
  String? code;
  String? nim;
  UploadBuktiController c = Get.put(UploadBuktiController());
  bool vis = false;
  @override
  DetailTransaksiController controller = Get.put(DetailTransaksiController());
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pembayaran',
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
          future: c.UBB(data['nim']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              nim = data['nim'];
              code = snapshot.data.data[index].codeTrans;
              return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: HexColor("#B6B6B6"), width: 1.sp)),
                    child: Column(
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
                                (snapshot.data.data[index].isConfirm == "1")
                                    ? "Telah dikonfirmasi"
                                    : " Belum dikonfirmasi",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: DataColors.primary800,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Text(
                                  "${DateFormat('dd MMMM yyyy').format(snapshot.data.data[index].dibuat)} | ${DateFormat('Hm').format(snapshot.data.data[index].dibuat)}",
                                  style: TextStyle(
                                      color: DataColors.Neutral300,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp)),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Text(
                                  "Kode transaksi : ${snapshot.data.data[index].codeTrans}",
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
                                            Text(snapshot.data.data[index].nim,
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
                                                  "Nama Mahasiswa",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(snapshot.data.data[index].name,
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
                                                  "Note",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(snapshot.data.data[index].note,
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
                                                  "Bukti Bayar",
                                                  style: TextStyle(
                                                      color:
                                                          DataColors.primary900,
                                                      fontSize: 10.sp),
                                                )),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(
                                                (snapshot.data.data[index]
                                                            .uploads ==
                                                        null)
                                                    ? "Tidak ada"
                                                    : "IMG",
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
                                  Text("Nominal",
                                      style: TextStyle(
                                          color: DataColors.primary900,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp)),
                                  Text(snapshot.data.data[index].nominal,
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
                    ),
                  ));
            } else {
              return Center(child: Text("Tidak Ada Data"));
            }
          }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () {
            Get.to(LihatBuktiPage(), arguments: [nim, code]);
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
            'Lihat Bukti',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
