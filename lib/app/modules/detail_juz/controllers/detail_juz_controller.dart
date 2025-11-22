import 'dart:convert';
import 'package:alquran/app/modules/detail_surah/controllers/detail_surah_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/juz.dart';

 class AyatFull {
  final detail.Ayat ayat;
  final String surahName;
  final String surahLatinName;

  AyatFull({
    required this.ayat,
    required this.surahName,
    required this.surahLatinName,
  });
}
class DetailJuzController extends GetxController {
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
    ));
  }

  return ayatList;
}
}
