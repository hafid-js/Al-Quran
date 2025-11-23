import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/juz.dart';
import 'package:alquran/app/modules/detail_juz/controllers/detail_juz_controller.dart';
import 'package:alquran/app/modules/detail_surah/controllers/detail_surah_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailJuzBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSurahController>(() => DetailSurahController());
  }
}

class DetailJuzView extends StatelessWidget {
  final int juzNumber = Get.arguments;
  final controller = Get.put(DetailJuzController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juz $juzNumber', style: TextStyle(color: appWhite)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<AyatFull>>(
        future: controller.getAyatFromJuz(juzNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data'));
          }

          final ayatList = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: ayatList.length,
            itemBuilder: (context, index) {
              final ayat = ayatList[index];

              Ayat surah = ayat.ayat;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode ? appPurple : Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/list.png"),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${surah.nomorAyat}",
                                style: TextStyle(color: appPurpleDark),
                              ),
                            ),
                          ),
                          Text(
                            ayat.surahLatinName,
                            textAlign: TextAlign.center,
                          ),
                          GetBuilder<DetailJuzController>(
                            builder: (c) => Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.bookmark_add_outlined),
                                ),
                                (surah.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(ayat);
                                        },
                                        icon: Icon(Icons.play_arrow),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (surah.kondisiAudio == "playing")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.pause),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.play_arrow),
                                                ),
                                          IconButton(
                                            onPressed: () {
                                              c.stopAudio(ayat);
                                            },
                                            icon: Icon(Icons.stop),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    surah.teksArab,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text(
                    surah.teksLatin,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 25),
                  Text(
                    surah.teksIndonesia,
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
