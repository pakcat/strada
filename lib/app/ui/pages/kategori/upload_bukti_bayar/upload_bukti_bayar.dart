import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:gostrada/app/ui/pages/kategori/upload_bukti_bayar/tambahpembayaran/tp.dart';
import 'package:gostrada/app/ui/theme/color.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/uploadbuktip_c.dart';

class UploadBuktiBayarPage extends StatelessWidget {
  @override
  UploadBuktiController controller = Get.put(UploadBuktiController());
  final box = GetStorage();
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Pembayaran',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: DataColors.primary800,
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
        child: FutureBuilder<dynamic>(
            future: controller.UBB(data['nim']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return uploadbuktibayar(
                        name: snapshot.data.data[index].name,
                        status: snapshot.data.data[index].isConfirm,
                        kodep: snapshot.data.data[index].codeTrans,
                        nim: snapshot.data.data[index].nim,
                        periode: snapshot.data.data[index].periode,
                        nominal: snapshot.data.data[index].nominal,
                        index: index);
                  },
                );
              } else {
                return Center(child: Text("Tidak Ada Data"));
              }
            }),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(bottom: 20, top: 10),
        child: ElevatedButton(
          onPressed: () {
            Get.to(TambahPembayaranPage());
          },
          style: ElevatedButton.styleFrom(
            primary: DataColors.primary, // background
            onPrimary: Colors.white, // foreground
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
          child: Text(
            'Tambah Pembayaran',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class uploadbuktibayar extends StatelessWidget {
  final String name;
  final String status;
  final String kodep;
  final String nim;
  final String periode;
  final String nominal;
  final int index;
  const uploadbuktibayar({
    Key? key,
    required this.name,
    required this.status,
    required this.kodep,
    required this.nim,
    required this.periode,
    required this.nominal,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 1.sp,
          color: DataColors.Neutral200,
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage("assets/icon/student.png"),
                    color: DataColors.primary400,
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  Text(name, style: TextStyle(color: DataColors.primary800))
                ],
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: DataColors.primary700,
                  ),
                  child: Text(
                    (status == "1")
                        ? "Telah dikonfirmasi"
                        : " Belum dikonfirmasi",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: DataColors.primary),
                child: Text(
                  kodep,
                  style: TextStyle(
                      color: DataColors.blusky,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 5.sp,
              ),
              Text("$nim | $periode",
                  style: TextStyle(color: DataColors.primary400))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Text(
            "Bukti Online",
            style: TextStyle(
                color: DataColors.primary800,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp),
          ),
        ),
        Container(
          height: 1.sp,
          color: DataColors.Neutral200,
        ),
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nominal,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: DataColors.primary800,
                    fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RoutName.detailpembayaran, arguments: index);
                },
                child: Text(
                  "Lihat Rincian",
                  style: TextStyle(
                      color: DataColors.primary600,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 1.sp,
          color: DataColors.Neutral200,
        ),
      ]),
    );
  }
}
