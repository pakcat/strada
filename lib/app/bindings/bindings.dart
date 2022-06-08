import 'package:get/get.dart';
import 'package:gostrada/app/controllers/auth/auth_c.dart';
import 'package:gostrada/app/controllers/dashboard/dashboard_c.dart';
import 'package:gostrada/app/controllers/onboard/onboard_c.dart';
import 'package:gostrada/app/controllers/splashC/splash_c.dart';

class GlobalBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<OnboardController>(() => OnboardController());
    Get.put(AuthController());
    Get.put(DashboardController());
    
    
  }
}