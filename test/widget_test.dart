import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;
void main() async {
  Uri uri = Uri.parse('https://equran.id/api/v2/surat');
  var res = await http.get(uri);

  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];

  // print(data[113]["namaLatin"]);

  // data api to object

  Surah surahAnnas = Surah.fromJson(data[113]);

  // print(surahAnnas.nomor);

  Uri uriAnnas = Uri.parse('https://equran.id/api/v2/surat/${surahAnnas.nomor}');
  var resAnnas = await http.get(uriAnnas);

  Map<String, dynamic>? dataAnnas = (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];

   if (dataAnnas == null) {
    print('Data surah An-Nas kosong');
    return;
  }

  DetailSurah annas = DetailSurah.fromJson(dataAnnas);

  print(annas.nama);

}