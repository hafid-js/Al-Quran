import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

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
