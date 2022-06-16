import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/navigation/botnav_c.dart';
import 'package:gostrada/app/ui/pages/navigation/chat.dart';
import 'package:gostrada/app/ui/pages/navigation/dashboard.dart';
import 'package:gostrada/app/ui/pages/navigation/monitoring.dart';
import 'package:gostrada/app/ui/pages/navigation/percakapan.dart';
import 'package:gostrada/app/ui/pages/navigation/profile.dart';

import 'package:gostrada/app/ui/theme/color.dart';
import 'package:hexcolor/hexcolor.dart';

class BottomNavigationPage extends StatelessWidget {
  final List<Widget> pagesList = [
    DashboardPage(),
    MonitoringPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationController botNavController =
        Get.put(BottomNavigationController());
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: botNavController.selectedIdex.value,
          children: pagesList,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: HexColor('#3C5595'),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: BottomNavigationBar(
            backgroundColor: HexColor('#3C5595'),
            selectedItemColor: DataColors.blusky,
            unselectedItemColor: HexColor('#7D98CE'),
            onTap: (index) {
              botNavController.tappedIndex(index);
            },
            currentIndex: botNavController.selectedIdex.value,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: NavList,
          ),
        ),
      ),
    );
  }

  //list Bottom Navigation
  List<BottomNavigationBarItem> get NavList {
    return [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home_rounded,
          size: 32,
        ),
        label: 'Beranda',
      ),
      const BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/icon/botnav/monitoring.png"),
          size: 32,
        ),
        label: 'Monitoring',
      ),
      const BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/icon/botnav/chat.png"),
          size: 32,
        ),
        label: 'Chat',
      ),
      const BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage("assets/icon/botnav/person.png"),
          size: 32,
        ),
        label: 'Profil',
      ),
    ];
  }
}
