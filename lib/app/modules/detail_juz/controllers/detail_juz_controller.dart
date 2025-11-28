import 'dart:convert';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/modules/detail_surah/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/juz.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqlite_api.dart';

 class AyatFull {
  final detail.Ayat ayat;
  final String surahName;
  final String surahLatinName;
  String kondisiAudio;
  

  AyatFull({
    required this.ayat,
    required this.surahName,
    required this.surahLatinName,
    this.kondisiAudio = "stop",
    
  });
}
class DetailJuzController extends GetxController {

  final player = AudioPlayer();

  AyatFull? lastAyat;

  RxBool isDark = Get.isDarkMode.obs;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
    bool lastRead,
    String surah,
    AyatFull ayat,
    int indexAyat,
  ) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query(
        "bookmark",
        where:
            "surah = ? AND ayat = ? AND via = ? AND index_ayat = ? AND last_read = 0",
        whereArgs: [surah, ayat.ayat.nomorAyat, "surah", indexAyat],
      );

      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": ayat.surahLatinName,
        "ayat": ayat.ayat.nomorAyat,
        // "juz": juzNumber,
        "via": "juz",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back();

      // Get.snackbar(
      //   "Berhasil",
      //   "Berhasil menambahkan bookmark",
      //   colorText: appWhite,
      // );
    } else {
      // Get.snackbar(
      //   "Terjadi Kesalahan",
      //   "Bookmark telah tersedia",
      //   colorText: appWhite,
      // );
    }

    var data = await db.query("bookmark");
    print(data);
  }


Future<List<AyatFull>> getAyatFromJuz(int juzNumber) async {
  final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/juz/$juzNumber'));
  final data = jsonDecode(response.body);
  final juz = Juz.fromJson(data['data']);
   final DetailSurahController detailSurahController = Get.find<DetailSurahController>();
  

  List<AyatFull> ayatList = [];

  for (var ayah in juz.ayahs!) {
    final surahDetail = await detailSurahController.getDetailSurah(ayah.surah!.number.toString());
    final ayatDetail = surahDetail.ayat.firstWhere(
      (a) => a.nomorAyat == ayah.numberInSurah,
    );

    ayatList.add(AyatFull(
      ayat: ayatDetail,
      surahName: surahDetail.nama, 
      surahLatinName: surahDetail.namaLatin,
      kondisiAudio: ayatDetail.kondisiAudio
    ));
  }

  return ayatList;
}

void playAudio(AyatFull ayat) async {
  detail.Ayat ayatJuz = ayat.ayat;
    if (ayatJuz.audio.values.first.isNotEmpty) {
      try {
        if(lastAyat == null) {
          lastAyat = ayat;
        }
        lastAyat!.kondisiAudio = "stop";
        lastAyat = ayat;
                lastAyat!.kondisiAudio = "stop";
                update();
        await player.stop(); // mencegah tumpukan audio saat sedang berjalan
        await player.setUrl(ayatJuz.audio.values.first);
        ayatJuz.kondisiAudio = "playing";
        update();
        await player.play();
        ayatJuz.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      }

      // Listening to errors during playback (e.g. lost network connection)
      player.errorStream.listen((PlayerException e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat memutar audio",
        );
      });
    }
  }

  void pauseAudio(AyatFull ayat) async {
    detail.Ayat ayatJuz = ayat.ayat;
    try {
      await player.pause();
      ayatJuz.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    }

    // Listening to errors during playback (e.g. lost network connection)
    player.errorStream.listen((PlayerException e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    });
  }

  void stopAudio(AyatFull ayat) async {
    detail.Ayat ayatJuz = ayat.ayat;
    try {
      await player.stop();
      ayatJuz.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    }

    // Listening to errors during playback (e.g. lost network connection)
    player.errorStream.listen((PlayerException e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat stop audio",
      );
    });
  }

  void resumeAudio(AyatFull ayat) async {
    detail.Ayat ayatJuz = ayat.ayat;
    try {
      ayatJuz.kondisiAudio = "playing";
      update();
      await player.play();
      ayatJuz.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    }

    // Listening to errors during playback (e.g. lost network connection)
    player.errorStream.listen((PlayerException e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat play audio",
      );
    });
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
