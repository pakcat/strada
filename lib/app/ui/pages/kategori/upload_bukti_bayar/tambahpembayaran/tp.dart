import 'dart:io';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/controllers/uploadbuktip_c.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/color.dart';

class TambahPembayaranPage extends StatefulWidget {
  @override
  State<TambahPembayaranPage> createState() => _TambahPembayaranPageState();
}

class _TambahPembayaranPageState extends State<TambahPembayaranPage> {
  final ImagePicker _picker = ImagePicker();

  dispose() {
    controller.txt.clear();
    super.dispose();
  }

  final box = GetStorage();
  UploadBuktiController controller = Get.put(UploadBuktiController());
  String? selectedidperiode;
  String? selectedValue1;
  String? selec;
  String? selecc;
  String selectedValue2 = "text";
  var index;
  @override
  Widget build(BuildContext context) {
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Data',
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
      body: SafeArea(
        child: FutureBuilder<dynamic>(
            future: controller.GetTP(data['nim']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Periode"),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Center(
                        child: CustomDropdownButton2(
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.sp),
                              color: HexColor("#F3F3F3")),
                          buttonWidth: 90.w,
                          dropdownWidth: 90.w,
                          hint: '',
                          dropdownItems: controller.periode,
                          value: selectedValue1,
                          onChanged: (value) {
                            setState(() {
                              index = controller.periode.indexOf(value!);

                              selectedValue1 = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Kode Transaksi"),
                      Center(
                        child: CustomDropdownButton2(
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.sp),
                              color: HexColor("#F3F3F3")),
                          buttonWidth: 90.w,
                          dropdownWidth: 90.w,
                          hint: '',
                          dropdownItems: controller.kode,
                          value: selec,
                          onChanged: (value) {
                            setState(() {
                              selectedValue2 = value as String;
                              selec = value as String;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Nominal"),
                      SizedBox(
                        height: 5.sp,
                      ),
                      FutureBuilder<dynamic>(
                          future: controller.getnominal(selectedValue2),
                          builder: (context, snapshot) {
                            return TextField(
                              controller: controller.txt,
                              decoration: InputDecoration(
                                enabled: false,
                                filled: true,
                                fillColor: HexColor("#F3F3F3"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent, width: 2.0),
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Catatan"),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor("#F3F3F3"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.sp),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text("Bukti Bayar"),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.sp, horizontal: 10.sp),
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: DataColors.primary)),
                              child: Center(
                                  child: Text(
                                "Pilih File",
                                style: TextStyle(
                                    color: DataColors.primary,
                                    fontWeight: FontWeight.w700),
                              ))),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      (image != null)
                          ? Center(
                              child: Container(
                                  height: 100.sp,
                                  width: 100.sp,
                                  child: Image.file(image!)),
                            )
                          : Text("Select Image")
                    ],
                  ),
                );
              } else {
                return Center(child: Text("Tidak Ada Data"));
              }
            }),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: () {
            controller.postbukti(
                image,
                data['nim'],
                controller.idperiode[index],
                selectedValue2,
                controller.txt.toString());
            Get.offAllNamed(RoutName.root);
          },
          style: ElevatedButton.styleFrom(
            primary: DataColors.primary, // background
            onPrimary: Colors.white, // foreground
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          child: Text(
            'Simpan Data',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
