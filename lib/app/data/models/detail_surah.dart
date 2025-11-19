// API URL : https://equran.id/api/v2/surat/1
// GET detail surah berdasarkan nomornya

import 'dart:convert';

DetailSurahResponse DetailSurahResponseFromJson(String str) =>
    DetailSurahResponse.fromJson(json.decode(str));

class DetailSurahResponse {
  final int code;
  final String message;
  final DetailSurah data;

  DetailSurahResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DetailSurahResponse.fromJson(Map<String, dynamic> json) =>
      DetailSurahResponse(
        code: json["code"],
        message: json["message"],
        data: DetailSurah.fromJson(json["data"]),
      );
}

class DetailSurah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Ayat> ayat;
  final SurahNav? suratSelanjutnya;
  final SurahNav? suratSebelumnya;

  DetailSurah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.ayat,
    required this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map<String, String>.from(json["audioFull"] ?? {}),
        ayat: List<Ayat>.from(
          (json["ayat"] as List).map((x) => Ayat.fromJson(x)),
        ),
        suratSelanjutnya: (json["suratSelanjutnya"] is Map<String, dynamic>)
    ? SurahNav.fromJson(json["suratSelanjutnya"])
    : null,
suratSebelumnya: (json["suratSebelumnya"] is Map<String, dynamic>)
    ? SurahNav.fromJson(json["suratSebelumnya"])
    : null,
      );
}

class Ayat {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String> audio;

  Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        nomorAyat: json["nomorAyat"],
        teksArab: json["teksArab"],
        teksLatin: json["teksLatin"],
        teksIndonesia: json["teksIndonesia"],
        audio: Map<String, String>.from(json["audio"] ?? {}),
      );
}

class SurahNav {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SurahNav({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SurahNav.fromJson(Map<String, dynamic> json) => SurahNav(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
      );
}
