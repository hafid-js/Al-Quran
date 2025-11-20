// API URL : https://equran.id/api/v2/surat/1
// GET detail surah berdasarkan nomornya
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
    nomor: json["nomor"] ?? 0,
    nama: json["nama"] ?? "",
    namaLatin: json["namaLatin"] ?? "",
    jumlahAyat: json["jumlahAyat"] ?? 0,
    tempatTurun: json["tempatTurun"] ?? "",
    arti: json["arti"] ?? "",
    deskripsi: json["deskripsi"] ?? "",
    audioFull: Map<String, String>.from(json["audioFull"] ?? {}),
    ayat: (json["ayat"] != null)
        ? List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x)))
        : [],
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
