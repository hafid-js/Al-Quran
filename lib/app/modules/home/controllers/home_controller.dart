import 'dart:convert';

import 'package:alquran/app/contants/color.dart';
import 'package:alquran/app/data/models/juz.dart' hide Surah;
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool isDark = false.obs;

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
    List<Juz> allJuz = [];

    for (int i = 1; i <= 30; i++) {
      Uri uri = Uri.parse('https://api.alquran.cloud/v1/juz/$i');
      var res = await http.get(uri);

      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];

      Juz juz = Juz.fromJson(data);

      allJuz.add(juz);
    }

    return allJuz;
  }
}
