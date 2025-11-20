import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    onPressed: () => Get.back(),
    icon: Icon(Icons.arrow_back),
    color: appWhite,
  ),
        title: Text('SURAH ${surah.namaLatin.toUpperCase()}', style: TextStyle(color: appWhite),),
        centerTitle: true,
      ),
      body: FutureBuilder<detail.DetailSurah>(
        future: controller.getDetailSurah(surah.nomor.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Tidak ada data'));
          }

          final detailSurah = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: detailSurah.ayat.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          detailSurah.namaLatin.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "(${detailSurah.arti.toUpperCase()})",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${detailSurah.jumlahAyat} Ayat | ${detailSurah.tempatTurun}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }

              final ayat = detailSurah.ayat[index - 1];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(child: Text('${ayat.nomorAyat}')),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.bookmark_add_outlined),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.play_arrow),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    ayat.teksArab,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text(
                    ayat.teksLatin,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    ayat.teksIndonesia,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 50),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
