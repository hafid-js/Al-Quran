import 'dart:convert';
import 'package:alquran/app/modules/detail_surah/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/juz.dart' as juz_model;



class DetailJuzController extends GetxController {
  final DetailSurahController detailSurahController = Get.put(DetailSurahController());

  Future<List<detail.Ayat>> getAyatFromJuz(int juzNumber) async {
  final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/juz/$juzNumber'));
  final data = jsonDecode(response.body);
  final juz_model.Juz juzData = juz_model.Juz.fromJson(data['data']);

  List<detail.Ayat> ayatList = [];

  for (var ayah in juzData.ayahs!) {
    final surahDetail = await detailSurahController.getDetailSurah(ayah.surah!.number.toString());
    final ayatDetail = surahDetail.ayat.firstWhere(
      (a) => a.nomorAyat == ayah.numberInSurah,
    );
    ayatList.add(ayatDetail);
  }

  return ayatList;
}

}
