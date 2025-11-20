// API URL : https://api.alquran.cloud/v1/juz/1
// GET all ayat per juz dalam Al-Quran

class Juz {
  int? number;
  List<Ayah>? ayahs;
  Surahs? surahs;
  Edition? edition;

  Juz({this.number, this.ayahs, this.surahs, this.edition});

  Juz.fromJson(Map<String, dynamic> json) {
    number = json['number'];

    if (json['ayahs'] != null) {
      ayahs = [];
      json['ayahs'].forEach((v) {
        ayahs!.add(Ayah.fromJson(v));
      });
    }

    surahs =
        json['surahs'] != null ? Surahs.fromJson(json['surahs']) : null;

    edition =
        json['edition'] != null ? Edition.fromJson(json['edition']) : null;
  }
}

class Ayah {
  int? number;
  String? text;
  Surah? surah;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  // bool? sajda;

  Ayah({
    this.number,
    this.text,
    this.surah,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    // this.sajda,
  });

  Ayah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    surah = json['surah'] != null ? Surah.fromJson(json['surah']) : null;
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    // sajda = json['sajda'];
  }
}


class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  int? numberOfAyahs;

  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.numberOfAyahs,
  });

  Surah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
  }
}


class Surahs {
  Map<String, Surah> items = {};

  Surahs.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      items[key] = Surah.fromJson(value);
    });
  }
}


class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  String? direction;

  Edition(
      {this.identifier,
      this.language,
      this.name,
      this.englishName,
      this.format,
      this.type,
      this.direction});

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['language'] = this.language;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['format'] = this.format;
    data['type'] = this.type;
    data['direction'] = this.direction;
    return data;
  }
}
