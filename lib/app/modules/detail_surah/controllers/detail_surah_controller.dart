import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class DetailSurahController extends GetxController {
Future<DetailSurah> getDetailSurah(String id) async {
    Uri uri = Uri.parse('https://equran.id/api/v2/surat/$id');
    var res = await http.get(uri);

      Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];

      return DetailSurah.fromJson(data);
  }
}
