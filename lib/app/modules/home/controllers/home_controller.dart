import 'dart:convert';

import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Future<List<Surah>> getAllSurah() async {
    Uri uri = Uri.parse('https://equran.id/api/v2/surat');
    var res = await http.get(uri);

      List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

      if(data == null || data.isEmpty){
        return [];
      } else {
        return data.map((e) => Surah.fromJson(e)).toList();
      }
  }
}
