// API URL : https://equran.id/apidev/v2

// GET semua surah dalam alquran

import 'dart:convert';

QuranResponse quranResponseFromJson(String str) =>
    QuranResponse.fromJson(json.decode(str));

String quranResponseToJson(QuranResponse data) => json.encode(data.toJson());

class QuranResponse {
  int code;
  String message;
  List<Surah> data;

  QuranResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory QuranResponse.fromJson(Map<String, dynamic> json) => QuranResponse(
        code: json["code"],
        message: json["message"],
        data: List<Surah>.from(
          json["data"].map((x) => Surah.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Surah {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String tempatTurun;
  String arti;
  String deskripsi;
  Map<String, String> audioFull;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": Map.from(audioFull)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
