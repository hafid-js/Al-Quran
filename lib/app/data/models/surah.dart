// API URL : https://equran.id/apidev/v2

// GET semua surah dalam alquran


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
    nomor: json["nomor"] ?? 0,
    nama: json["nama"] ?? "",
    namaLatin: json["namaLatin"] ?? "",
    jumlahAyat: json["jumlahAyat"] ?? 0,
    tempatTurun: json["tempatTurun"] ?? "",
    arti: json["arti"] ?? "",
    deskripsi: json["deskripsi"] ?? "",
    audioFull: json["audioFull"] != null
        ? Map<String, String>.from(json["audioFull"])
        : {},
  );

  Map<String, dynamic> toJson() => {
    "nomor": nomor,
    "nama": nama,
    "namaLatin": namaLatin,
    "jumlahAyat": jumlahAyat,
    "tempatTurun": tempatTurun,
    "arti": arti,
    "deskripsi": deskripsi,
    "audioFull": Map.from(
      audioFull,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
