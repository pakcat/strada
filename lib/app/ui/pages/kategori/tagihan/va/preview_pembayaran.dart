import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/tagihan_c.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/va/bankpage.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/va/va.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:sizer/sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../controllers/keuangan/detailtransaksi.dart';
import '../../../../theme/color.dart';

class PreviewPembayaranPage extends StatefulWidget {
  @override
  State<PreviewPembayaranPage> createState() => _PreviewPembayaranPageState();
}

class _PreviewPembayaranPageState extends State<PreviewPembayaranPage> {
  @override
  Widget build(BuildContext context) {
    var array = Get.arguments;
    bool isvisible = false;

    TagihanController controller = Get.put(TagihanController());
    DetailTransaksiController c = Get.put(DetailTransaksiController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Preview',
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.sp),
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageIcon(
                    AssetImage("assets/images/money.png"),
                    color: DataColors.primary400,
                    size: 30.sp,
                  ),
                ),
                Text(
                  "Pembayaran Offline",
                  style: TextStyle(
                      color: DataColors.primary800,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.sp),
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.sp),
              child: Center(
                child: QrImage(
                  data: array[0].toString(),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.sp),
                  child: Icon(
                    Icons.info_outline,
                    color: DataColors.Neutral400,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.sp),
                  width: 70.w,
                  child: Text(
                    "Kode transaksi dapat dilihat pada bagian bawah barcode atau qrcode, kode tersebut yang akan menjadi acuan pembayaran",
                    style: TextStyle(color: DataColors.Neutral400),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10.sp),
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            InkWell(
              onTap: () {
                Get.to(VAPage(), arguments: [array[0], array[1]]);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageIcon(
                            AssetImage("assets/images/va.png"),
                            color: DataColors.primary400,
                            size: 30.sp,
                          ),
                        ),
                        Text(
                          "Virtual Account (Cek Otomatis)",
                          style: TextStyle(
                              color: DataColors.primary800,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15.sp,
                        color: DataColors.primary800,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            InkWell(
              onTap: () {
                isvisible = c.onclick(isvisible);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageIcon(
                            AssetImage("assets/images/tf.png"),
                            color: DataColors.primary400,
                            size: 30.sp,
                          ),
                        ),
                        Text(
                          "Transfer Bank",
                          style: TextStyle(
                              color: DataColors.primary800,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15.sp,
                        color: DataColors.primary800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1.5.sp,
              width: 100.w,
              color: DataColors.Neutral200,
            ),
            GetBuilder<DetailTransaksiController>(
              init: DetailTransaksiController(),
              initState: (_) {},
              builder: (_) {
                return Visibility(
                  visible: isvisible,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(BankPage(), arguments: 0);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.sp, right: 10.sp),
                                      height: 30.sp,
                                      width: 30.sp,
                                      child: Image(
                                        image:
                                            AssetImage("assets/images/BSI.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "BSI",
                                    style: TextStyle(
                                        color: DataColors.primary800,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1.5.sp,
                        width: 100.w,
                        color: DataColors.Neutral200,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(BankPage(), arguments: 1);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.sp, right: 10.sp),
                                      height: 30.sp,
                                      width: 30.sp,
                                      child: Image(
                                        image:
                                            AssetImage("assets/images/BRI.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "BRI",
                                    style: TextStyle(
                                        color: DataColors.primary800,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
        ));
  }
}
