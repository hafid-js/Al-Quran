// API URL : https://equran.id/api/v2/tafsir/1
// GET detail ayat dan tafsir berdasarkan nomornya


import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final int code;
  final String message;
  final Data data;

  Welcome({
    required this.code,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final Map<String, String> audioFull;
  final List<Tafsir> tafsir;
  final SuratSelanjutnya? suratSelanjutnya;
  final bool suratSebelumnya;

  Data({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
    required this.tafsir,
    this.suratSelanjutnya,
    required this.suratSebelumnya,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nomor: json["nomor"] ?? 0,
        nama: json["nama"] ?? '',
        namaLatin: json["namaLatin"] ?? '',
        jumlahAyat: json["jumlahAyat"] ?? 0,
        tempatTurun: json["tempatTurun"] ?? '',
        arti: json["arti"] ?? '',
        deskripsi: json["deskripsi"] ?? '',
        audioFull: json["audioFull"] != null
            ? Map<String, String>.from(json["audioFull"])
            : {},
        tafsir: json["tafsir"] != null
            ? List<Tafsir>.from(json["tafsir"].map((x) => Tafsir.fromJson(x)))
            : [],
        suratSelanjutnya: json["suratSelanjutnya"] != null
            ? SuratSelanjutnya.fromJson(json["suratSelanjutnya"])
            : null,
        suratSebelumnya: json["suratSebelumnya"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": audioFull,
        "tafsir": tafsir.map((x) => x.toJson()).toList(),
        "suratSelanjutnya": suratSelanjutnya?.toJson(),
        "suratSebelumnya": suratSebelumnya,
      };
}

class SuratSelanjutnya {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;

  SuratSelanjutnya({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSelanjutnya.fromJson(Map<String, dynamic> json) =>
      SuratSelanjutnya(
        nomor: json["nomor"] ?? 0,
        nama: json["nama"] ?? '',
        namaLatin: json["namaLatin"] ?? '',
        jumlahAyat: json["jumlahAyat"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
      };
}

class Tafsir {
  final int ayat;
  final String teks;

  Tafsir({
    required this.ayat,
    required this.teks,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        ayat: json["ayat"] ?? 0,
        teks: json["teks"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "teks": teks,
      };
}
