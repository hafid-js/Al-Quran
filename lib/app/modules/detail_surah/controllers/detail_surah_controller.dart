import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  RxString kondisiAudio = "stop".obs;
  final player = AudioPlayer();

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri uri = Uri.parse('https://equran.id/api/v2/surat/$id');
    var res = await http.get(uri);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void pauseAudio() async {
    try {
        await player.pause();
                      kondisiAudio.value = "pause";
        
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

  void stopAudio() async {
    try {
        await player.stop();
        kondisiAudio.value = "stop";
        
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

  void resumeAudio() async {
    try {
              kondisiAudio.value = "playing";
        await player.play();
        kondisiAudio.value = "stop";
        
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

  void playAudio(String? url) async {
    if (url != null) {
      try {
        await player.stop(); // mencegah tumpukan audio saat sedang berjalan
        await player.setUrl(url);
        kondisiAudio.value = "playing";
        await player.play();
        kondisiAudio.value = "stop";
        await player.stop();
        
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
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "URL Audio tidak ada / tidak dapat diakses",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
