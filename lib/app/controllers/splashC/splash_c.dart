import 'package:get/get.dart';
import 'package:gostrada/app/controllers/auth/auth_c.dart';
import 'package:gostrada/app/routes/rout_name.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final c = Get.find<AuthController>();
  final int timerSplash = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: timerSplash), () async {
      final box = GetStorage();
      box.read('isViewed');

      if (box.read('isViewed') == true) {
        // if onboard is viewed
        final dataUser = box.read('dataUser');

        // check if user data is not null
        if (dataUser != null) {
          print(
              'onboard is viewed and user data has been previously saved, go to dashboard ');
          // user data has been previously saved, go to dashboard
          c.login(dataUser['username'], dataUser['password']);
        } else {
          print(
              'onboard is viewed, but user data has never been savedp before, go to Login');
          Get.offAllNamed(RoutName.login);
        }
      } else {
        // onboard never seen before
        print('onboard never seen before, go to see first');
        Get.offAllNamed(RoutName.onboard);
      }
    });
  }
}
