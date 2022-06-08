import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gostrada/app/controllers/tagihan_c.dart';
import 'package:gostrada/app/data/models/nominal.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/dpp/buattagihan.dart';
import 'package:gostrada/app/ui/pages/kategori/tagihan/spp/buattagihan.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../../routes/rout_name.dart';
import '../../../theme/color.dart';

class JenisTagihanPage extends StatefulWidget {
  @override
  State<JenisTagihanPage> createState() => _JenisTagihanPageState();
}

class _JenisTagihanPageState extends State<JenisTagihanPage> {
  List<Widget> _cardList = [];

  final box = GetStorage();
  var index = 100;

  String? selectedId;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    TagihanController controller = Get.put(TagihanController());
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    Map data = box.read("dataUser") as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Tagihan',
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
        child: FutureBuilder<dynamic>(
            future: controller.getcredit(data['nim']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jenis Tagihan",
                          style: TextStyle(
                              color: DataColors.primary800,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          children: [
                            CustomDropdownButton2(
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: HexColor("#F3F3F3")),
                              buttonWidth: 80.w,
                              dropdownWidth: 80.w,
                              hint: 'Pilih Tagihan',
                              dropdownItems: controller.name,
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  index = controller.name.indexOf(value!);
                                  print(index);
                                  selectedValue = value as String;
                                  controller.loadtagihan(
                                      data["nim"], controller.id[index]);
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     //
                            //   },
                            //   child: Container(
                            //     decorat)ion: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(8.sp),
                            //         border: Border.all(
                            //             color: DataColors.primary600,
                            //             width: 1.sp)),
                            //     padding: EdgeInsets.all(4.sp),
                            //     child: Text(
                            //       "Load Tagihan",
                            //       style: TextStyle(
                            //           color: DataColors.primary600,
                            //           fontSize: 9.sp),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        GetBuilder<TagihanController>(initState: (_) {
                          // controller.resetTotal();
                        }, builder: (_) {
                          if (_.data.isEmpty) {
                            return Text("Silahkan Tambah Data");
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: _.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(_.data[index].data![0].nominal);
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.0.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _.data[index].data![0].namaTagihan,
                                      style: TextStyle(
                                          color: DataColors.primary800),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Text(_.data[index].data![0].labelJenis,
                                        style: TextStyle(
                                            color: DataColors.primary)),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.sp, horizontal: 4.sp),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.sp),
                                              color: DataColors.primary100),
                                          child: Text(
                                              "${formatCurrency.format(_.data[index].data![0].nominal)}",
                                              style: TextStyle(
                                                  color:
                                                      DataColors.primary600)),
                                        ),
                                        SizedBox(
                                          width: 10.sp,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.isVisible[index] =
                                                controller.toggle(controller
                                                    .isVisible[index]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                border: Border.all(
                                                    color:
                                                        DataColors.primary600,
                                                    width: 1.sp)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.sp,
                                                horizontal: 4.sp),
                                            child: Text(
                                              "Cicil",
                                              style: TextStyle(
                                                  color: DataColors.primary600,
                                                  fontSize: 10.sp),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    GetBuilder<TagihanController>(
                                      init: TagihanController(),
                                      initState: (_) {},
                                      builder: (_) {
                                        return Visibility(
                                          visible: controller.isVisible[index],
                                          maintainSize: false,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Masukkan Nominal: ",
                                                  style: TextStyle(
                                                      color: DataColors
                                                          .primary800),
                                                ),
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                TextField(
                                                  onSubmitted: (value) {
                                                    int val =
                                                        (int.tryParse(value) ??
                                                            0);
                                                    int nominal = _.data[index]
                                                        .data![0].nominal;
                                                    controller
                                                        .totaltagihan.value = 0;
                                                    if (nominal < val) {
                                                      controller
                                                              .controllers[index]
                                                              .text =
                                                          nominal.toString();
                                                      controller
                                                              .controllers2[index]
                                                              .text =
                                                          formatCurrency
                                                              .format(0);
                                                    } else {
                                                      int num = _.data[index]
                                                          .data![0].nominal;
                                                      controller
                                                              .controllers2[index]
                                                              .text =
                                                          formatCurrency.format(
                                                              ((num) -
                                                                  int.parse(
                                                                      value)));
                                                    }

                                                    for (var nominalBayar
                                                        in controller
                                                            .controllers) {
                                                      controller.totaltagihan
                                                              .value +=
                                                          (int.tryParse(
                                                                  nominalBayar
                                                                      .text) ??
                                                              0);
                                                    }

                                                    _.update();

                                                    // for (var i = 0;
                                                    //     i < _.data.length;
                                                    //     i++) {
                                                    //   controller.totaltagihan
                                                    //           .value +=
                                                    //       int.tryParse(
                                                    //               _controllers[
                                                    //                       i]
                                                    //                   .text) ??
                                                    //           0;
                                                    // }
                                                  },
                                                  onChanged: (value) {
                                                    if (value.isEmpty) {
                                                      value = 0.toString();
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: controller
                                                      .controllers[index],
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.sp),
                                                      borderSide: BorderSide(
                                                          color: DataColors
                                                              .Neutral200,
                                                          width: 2.0),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                TextField(
                                                  controller: controller
                                                      .controllers2[index],
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    prefixIcon: Text("Sisa"),
                                                    enabled: false,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.sp),
                                                      borderSide: BorderSide(
                                                          color: DataColors
                                                              .Neutral200,
                                                          width: 2.0),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                        // (index == 100)
                        //     ? Text("Silahkan Tambah Data")
                        //     : FutureBuilder<dynamic>(
                        //         future: controller.loadtagihan(
                        //             data["nim"], controller.id[index]),
                        //         builder: (context, snapshot) {
                        //           if (snapshot.hasData) {
                        //             return ListView.builder(
                        //               shrinkWrap: true,
                        //               physics: ScrollPhysics(),
                        //               itemCount: snapshot.data.total,
                        //               itemBuilder:
                        //                   (BuildContext context, int index) {
                        //                 _controllers
                        //                     .add(new TextEditingController());
                        //                 _controllers2
                        //                     .add(new TextEditingController());
                        //                 isVisible.add(false);

                        //                 return Padding(
                        //                   padding:
                        //                       EdgeInsets.only(bottom: 15.0.sp),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         snapshot.data.data[index]
                        //                             .namaTagihan,
                        //                         style: TextStyle(
                        //                             color:
                        //                                 DataColors.primary800),
                        //                       ),
                        //                       SizedBox(
                        //                         height: 10.sp,
                        //                       ),
                        //                       Text(
                        //                           snapshot.data.data[index]
                        //                               .labelJenis,
                        //                           style: TextStyle(
                        //                               color:
                        //                                   DataColors.primary)),
                        //                       SizedBox(
                        //                         height: 10.sp,
                        //                       ),
                        //                       Row(
                        //                         children: [
                        //                           Container(
                        //                             padding:
                        //                                 EdgeInsets.symmetric(
                        //                                     vertical: 2.sp,
                        //                                     horizontal: 4.sp),
                        //                             decoration: BoxDecoration(
                        //                                 borderRadius:
                        //                                     BorderRadius
                        //                                         .circular(2.sp),
                        //                                 color: DataColors
                        //                                     .primary100),
                        //                             child: Text(
                        //                                 "${formatCurrency.format(snapshot.data.data[index].nominal)}",
                        //                                 style: TextStyle(
                        //                                     color: DataColors
                        //                                         .primary600)),
                        //                           ),
                        //                           SizedBox(
                        //                             width: 10.sp,
                        //                           ),
                        //                           InkWell(
                        //                             onTap: () {
                        //                               isVisible[index] =
                        //                                   controller.toggle(
                        //                                       isVisible[index]);
                        //                               print(isVisible);
                        //                             },
                        //                             child: Container(
                        //                               decoration: BoxDecoration(
                        //                                   borderRadius:
                        //                                       BorderRadius
                        //                                           .circular(
                        //                                               8.sp),
                        //                                   border: Border.all(
                        //                                       color: DataColors
                        //                                           .primary600,
                        //                                       width: 1.sp)),
                        //                               padding:
                        //                                   EdgeInsets.symmetric(
                        //                                       vertical: 2.sp,
                        //                                       horizontal: 4.sp),
                        //                               child: Text(
                        //                                 "Cicil",
                        //                                 style: TextStyle(
                        //                                     color: DataColors
                        //                                         .primary600,
                        //                                     fontSize: 10.sp),
                        //                               ),
                        //                             ),
                        //                           )
                        //                         ],
                        //                       ),
                        //                       GetBuilder<TagihanController>(
                        //                         init: TagihanController(),
                        //                         initState: (_) {},
                        //                         builder: (_) {
                        //                           return Visibility(
                        //                             visible: isVisible[index],
                        //                             maintainSize: false,
                        //                             child: Container(
                        //                               margin:
                        //                                   EdgeInsets.symmetric(
                        //                                       vertical: 20.sp),
                        //                               child: Column(
                        //                                 crossAxisAlignment:
                        //                                     CrossAxisAlignment
                        //                                         .start,
                        //                                 children: [
                        //                                   Text(
                        //                                     "Masukkan Nominal: ",
                        //                                     style: TextStyle(
                        //                                         color: DataColors
                        //                                             .primary800),
                        //                                   ),
                        //                                   SizedBox(
                        //                                     height: 10.sp,
                        //                                   ),
                        //                                   TextField(
                        //                                     onSubmitted:
                        //                                         (value) {
                        //                                       controller
                        //                                           .totaltagihan
                        //                                           .value += int
                        //                                               .tryParse(
                        //                                                   value) ??
                        //                                           0;
                        //                                     },
                        //                                     onChanged: (value) {
                        //                                       controller
                        //                                           .totaltagihan
                        //                                           .value = 0;

                        //                                       if (value
                        //                                           .isEmpty) {
                        //                                         value = 0
                        //                                             .toString();
                        //                                       }
                        //                                       var num = snapshot
                        //                                           .data
                        //                                           .data[index]
                        //                                           .nominal;
                        //                                       _controllers2[
                        //                                                   index]
                        //                                               .text =
                        //                                           formatCurrency
                        //                                               .format(((num) -
                        //                                                       int.tryParse(value) ??
                        //                                                   0));
                        //                                     },
                        //                                     keyboardType:
                        //                                         TextInputType
                        //                                             .number,
                        //                                     inputFormatters: <
                        //                                         TextInputFormatter>[
                        //                                       FilteringTextInputFormatter
                        //                                           .digitsOnly
                        //                                     ],
                        //                                     controller:
                        //                                         _controllers[
                        //                                             index],
                        //                                     decoration:
                        //                                         InputDecoration(
                        //                                       filled: true,
                        //                                       fillColor:
                        //                                           Colors.white,
                        //                                       enabledBorder:
                        //                                           OutlineInputBorder(
                        //                                         borderRadius:
                        //                                             BorderRadius
                        //                                                 .circular(
                        //                                                     6.sp),
                        //                                         borderSide: BorderSide(
                        //                                             color: DataColors
                        //                                                 .Neutral200,
                        //                                             width: 2.0),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   SizedBox(
                        //                                     height: 10.sp,
                        //                                   ),
                        //                                   TextField(
                        //                                     controller:
                        //                                         _controllers2[
                        //                                             index],
                        //                                     decoration:
                        //                                         InputDecoration(
                        //                                       isDense: true,
                        //                                       prefixIcon:
                        //                                           Text("Sisa"),
                        //                                       enabled: false,
                        //                                       enabledBorder:
                        //                                           OutlineInputBorder(
                        //                                         borderRadius:
                        //                                             BorderRadius
                        //                                                 .circular(
                        //                                                     6.sp),
                        //                                         borderSide: BorderSide(
                        //                                             color: DataColors
                        //                                                 .Neutral200,
                        //                                             width: 2.0),
                        //                                       ),
                        //                                     ),
                        //                                   )
                        //                                 ],
                        //                               ),
                        //                             ),
                        //                           );
                        //                         },
                        //                       )
                        //                     ],
                        //                   ),
                        //                 );
                        //               },
                        //             );
                        //           } else {
                        //             return Text("Silahkan Tambah Data");
                        //           }
                        //         })
                      ]),
                );
              } else {
                return Center(child: Text("Tidak Ada Tagihan"));
              }
            }),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<TagihanController>(builder: (_) {
            return Padding(
              padding: EdgeInsets.only(left: 12.sp, bottom: 15.sp),
              child: Text(
                "Total Tagihan \n ${formatCurrency.format(controller.totaltagihan.value)}",
                style: TextStyle(color: DataColors.primary600),
              ),
            );
          }),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                //controller.confirmtagihan(data["nim"], id_biaya, id_credit, bayar);
              },
              style: ElevatedButton.styleFrom(
                primary: DataColors.primary, // background
                onPrimary: Colors.white, // foreground
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.sp),
              ),
              child: Text(
                'Konfirmasi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
