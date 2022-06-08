import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/uploadbuktip_c.dart';
import 'package:gostrada/app/ui/theme/color.dart';

class LihatBuktiPage extends StatelessWidget {
  UploadBuktiController controller = Get.put(UploadBuktiController());
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lihat Bukti',
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
      body: Container(
        child: FutureBuilder<dynamic>(
            future: controller.LihatBukti(data[0], data[1]),
            builder: (context, snapshot) {
              print(data[0]);
              print(data[1]);
              if (snapshot.hasData) {
                print(snapshot.data.data[0].uploads);
                return CachedNetworkImage(
                  imageUrl: snapshot.data.data[0].uploads,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              } else {
                return Center(child: Text("Tidak Ada Gambar"));
              }
            }),
      ),
    );
  }
}
