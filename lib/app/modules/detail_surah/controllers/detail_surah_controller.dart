import 'dart:convert';
import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqlite_api.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();
  RxBool isDark = Get.isDarkMode.obs;
  Ayat? lastAyat;

  DatabaseManager database = DatabaseManager.instance;

  void addBookmark(
    bool lastRead,
    DetailSurah surah,
    Ayat ayat,
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
        whereArgs: [surah.namaLatin, ayat.nomorAyat, "surah", indexAyat],
      );

      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": surah.namaLatin,
        "ayat": ayat.nomorAyat,
        // "juz": juzNumber,
        "via": "surah",
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

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri uri = Uri.parse('https://equran.id/api/v2/surat/$id');
    var res = await http.get(uri);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void playAudio(Ayat ayat) async {
    if (ayat.audio.values.first.isNotEmpty) {
      try {
        lastAyat ??= ayat;
        lastAyat!.kondisiAudio = "stop";
        lastAyat = ayat;
        lastAyat!.kondisiAudio = "stop";
        update();
        await player.stop(); // mencegah tumpukan audio saat sedang berjalan
        await player.setUrl(ayat.audio.values.first);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
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

  void pauseAudio(Ayat ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
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

  void stopAudio(Ayat ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
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

  void resumeAudio(Ayat ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
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
