import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/modules/detail_juz/controllers/detail_juz_controller.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  final homeC = Get.find<HomeController>();

  DetailJuzController juzC = DetailJuzController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: controller.isDark.isTrue ? appWhite : Colors.grey[600],
        ),
        title: Text(
          '${surah.namaLatin.toUpperCase()}',
          style: TextStyle(
            color: controller.isDark.isTrue ? appWhite : appPurple,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: false,
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
          // final juzNumber = juzC.getAyatFromJuz(detailSurah.)

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: detailSurah.ayat.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () => Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Get.isDarkMode
                              ? appPurpleLight2.withValues(alpha: 0.3)
                              : appWhite,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Tafsir ${surah.namaLatin}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Html(
                              data: detailSurah.deskripsi,
                              style: {"*": Style(textAlign: TextAlign.justify)},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [appPurpleLight1, appPurpleDark],
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [appPurpleLight1, appPurpleDark],
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              child: Container(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -30,
                                      right: 0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Image.asset(
                                            "assets/images/alquran2.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              detailSurah.namaLatin
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: appWhite,
                                              ),
                                            ),
                                            Text(
                                              "(${detailSurah.arti.toUpperCase()})",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: appWhite,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 1,
                                              width: 200,
                                              color: Colors.white.withAlpha(
                                                100,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 3,
                                              ),
                                            ),
                                            Text(
                                              "${detailSurah.jumlahAyat} Ayat | ${detailSurah.tempatTurun}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: appWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              final ayat = detailSurah.ayat[index - 1];
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
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/list.png"),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${ayat.nomorAyat}",
                                style: TextStyle(color: appPurpleDark),
                              ),
                            ),
                          ),
                          GetBuilder<DetailSurahController>(
                            builder: (c) => Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "BOOKMARK",
                                      middleText: "Pilih Jenis Bookmark",
                                      middleTextStyle: TextStyle(color: Colors.black),
                                      titleStyle: TextStyle(fontWeight: FontWeight.w400),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await c.addBookmark(true, snapshot.data!, ayat, index);
                                            homeC.update();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: appPurple,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text("LAST READ"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                              c.addBookmark(false, snapshot.data!, ayat, index);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: appPurple,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text("BOOKMARK"),
                                        ),
                                      ],
                                    );
                                  },
                                  icon: Icon(Icons.bookmark_add_outlined),
                                ),
                                (ayat.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(ayat);
                                        },
                                        icon: Icon(Icons.play_arrow),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (ayat.kondisiAudio == "playing")
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
                    ayat.teksArab,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 25,
                      color: controller.isDark.isTrue
                          ? appWhite
                          : appPurpleDark,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    ayat.teksLatin,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: controller.isDark.isTrue ? appWhite : Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    ayat.teksIndonesia,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: controller.isDark.isTrue ? appWhite : Colors.black,
                    ),
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
