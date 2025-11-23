import 'dart:convert';

import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/juz.dart' hide Surah;
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
 RxBool isDark = Get.isDarkMode.obs;

  void changeThemeMode() async {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();

    final box = GetStorage();

    if(Get.isDarkMode) {
      box.remove("themeDark");
    } else {
          box.write("themeDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri uri = Uri.parse('https://equran.id/api/v2/surat');
    var res = await http.get(uri);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

Future<List<Juz>> getAllJuz() async {
  List<Future<Juz?>> futures = [];

  for (int i = 1; i <= 30; i++) {
    futures.add(fetchJuzWithRetry(i, retries: 3));
  }

  final results = await Future.wait(futures);
  return results.whereType<Juz>().toList();
}

Future<Juz?> fetchJuzWithRetry(int number, {int retries = 3}) async {
  while (retries > 0) {
    try {
      Uri uri = Uri.parse('https://api.alquran.cloud/v1/juz/$number');
      final res = await http.get(uri).timeout(Duration(seconds: 10));

      if (res.statusCode == 200) {
        Map<String, dynamic> data =
            (json.decode(res.body) as Map<String, dynamic>)["data"];
        return Juz.fromJson(data);
      } else {
        print('Failed Juz $number: status code ${res.statusCode}');
      }
    } catch (e) {
      print('Error fetching Juz $number: $e');
    }

    retries--;
    if (retries > 0) {
      await Future.delayed(Duration(seconds: 2)); // tunggu sebelum retry
      print('Retrying Juz $number, remaining attempts: $retries');
    }
  }

  print('Failed to fetch Juz $number after retries');
  return null;
}

}
