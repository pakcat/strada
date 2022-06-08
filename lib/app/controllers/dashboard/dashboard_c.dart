import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardController extends GetxController {
  final String urlPhoto = 'https://sia.iik-strada.ac.id/uploads/mhs/';
  TooltipBehavior? tooltipBehavior;

  // final List<ChartData> chartData = <ChartData>[
  //           ChartData(2010, 10.53),
  //           ChartData(2011, 9.5),
  //           ChartData(2012, 10),
  //           ChartData(2013, 9.4),
  //           ChartData(2014, 5.8),
  //           ChartData(2015, 4.9),
  //           ChartData(2016, 4.5),
  //           ChartData(2017, 3.6),
  //           ChartData(2018, 3.43),
  //       ];

  // final List chartData = List.generate(length, (index) => null);

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
}

class ChartData {
  ChartData(this.year, this.sales);
  final String year;
  final double sales;
}
