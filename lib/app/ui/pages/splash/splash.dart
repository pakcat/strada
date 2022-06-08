import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/splashC/splash_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';

class SplashPage extends StatelessWidget {
  final c = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DataColors.skyBlue,
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/images/logo/iiklogo.png'),
                height: 80,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: DataColors.primary700,
                  valueColor: AlwaysStoppedAnimation(
                    DataColors.blusky,
                  ),
                  minHeight: 5,
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
