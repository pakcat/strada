import 'dart:convert';

import 'package:get/get.dart';
import 'package:gostrada/app/data/models/getipk.dart';
import 'package:gostrada/app/ui/pages/navigation/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import '../../data/models/test_m.dart';

class DashboardController extends GetxController {
  final String urlPhoto = 'https://sia.iik-strada.ac.id/uploads/mhs/';
  TooltipBehavior? tooltipBehavior;

  // final List<ChartData> chartData = <ChartData>[
  //           ChartData("2010", "10.53"),
  //           ChartData(2011, 9.5),
  //           ChartData(2012, 10),
  //           ChartData(2013, 9.4),
  //           ChartData(2014, 5.8),
  //           ChartData(2015, 4.9),
  //           ChartData(2016, 4.5),
  //           ChartData(2017, 3.6),
  //           ChartData(2018, 3.43),
  //       ];

  List<String> urlImage = [
    'assets/images/dashboard/slider/slide1.png',
    'assets/images/dashboard/slider/slide2.png',
    'assets/images/dashboard/slider/slide3.png',
    'assets/images/dashboard/slider/slide4.png',
  ];
  List<String> capsSlider = [
    'Her-registrasi dan pemrograman KRS online',
    'Pengajuan daftar wisuda tahun 2022',
    'Pengumuman Perkuliahan Tatap Muka Terbatas semester genap tahun 2021/2022',
    'Penghitungan nilai dan IP mandiri',
  ];

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);
    super.onInit();
  }

  getipk(String nim) async {
    final Map<String, dynamic> dataBody = {
      RBModel.nim: nim,
    };

    var response = await http.post(
        Uri.parse("https://sia.iik-strada.ac.id/mobile/dashboard/show_ipk"),
        body: dataBody);

    if (response.statusCode == 200) {
      var databody = jsonDecode(response.body);
      // print(DataUser['data']);

      //var test = jsonDecode(DataUser['data']);
      //print(test);

      // List list =
      //result2['data'].map((data) => DataModel.fromJson(data)).toList();
      // print(result2);
      if (databody['error'] == true) {
        //show error
        return null;
      } else {
        var result = GetIpkModel.fromJson(databody);

        // for (var item = 0; item < result.data!.length; item++) {

        //   //listipk.add([result.data![item].semester, result.data![item].ipk]);
        // }

        final List<ChartData> chartData = List.generate(
            result.data!.length,
            (index) => ChartData("Semester " + result.data![index].semester,
                result.data![index].ipk));

        return chartData;
      }
    }
  }
}
