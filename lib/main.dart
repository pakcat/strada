import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/bindings/bindings.dart';
import 'package:gostrada/app/routes/app_page.dart';
import 'package:gostrada/app/ui/pages/splash/splash.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
  // disable rotate

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  GlobalBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins', scaffoldBackgroundColor: Colors.white),
        home: SplashPage(),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        getPages: AppPage.pages,
      );
    });
  }
}
