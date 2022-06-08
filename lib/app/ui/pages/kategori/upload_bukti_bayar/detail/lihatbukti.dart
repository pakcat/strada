import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostrada/app/controllers/uploadbuktip_c.dart';

class LihatBuktiPage extends StatelessWidget {
  UploadBuktiController controller = Get.put(UploadBuktiController());
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('LihatBuktiPage')),
      body: Container(
        child: FutureBuilder<dynamic>(
            future: controller.LihatBukti(data[0], data[1]),
            builder: (context, snapshot) {
              print(data[0]);
              print(data[1]);
              if (snapshot.hasData) {
                print(snapshot.data.data[0].uploads);
                return CachedNetworkImage(
                  imageUrl: "http://via.placeholder.com/350x150",
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
