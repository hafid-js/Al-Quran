String arabToLatin(String input) {
  final Map<String, String> map = {
    'ا': 'a',
    'أ': 'a',
    'إ': 'i',
    'آ': 'a',
    'ب': 'b',
    'ت': 't',
    'ث': 'ts',
    'ج': 'j',
    'ح': 'h',
    'خ': 'kh',
    'د': 'd',
    'ذ': 'dz',
    'ر': 'r',
    'ز': 'z',
    'س': 's',
    'ش': 'sy',
    'ص': 's',
    'ض': 'd',
    'ط': 't',
    'ظ': 'z',
    'ع': '',
    'غ': 'gh',
    'ف': 'f',
    'ق': 'q',
    'ك': 'k',
    'ل': 'l',
    'م': 'm',
    'ن': 'n',
    'ه': 'h',
    'و': 'w',
    'ي': 'y',
    'ى': 'a',
    'ة': 'h',
    'ٓ': '',
    'ٔ': '',
    'ٰ': 'a',
    'َ': 'a',
    'ِ': 'i',
    'ُ': 'u',
    'ّ': '',
    'ْ': '',
  };

  String output = "";
  bool tasydid = false;

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (char == 'ّ') {
      tasydid = true;
      continue;
    }

    String latin = map[char] ?? '';

    if (tasydid && latin.isNotEmpty) {
      latin = latin * 2;
      tasydid = false;
    }

    output += latin;
  }

  return output;
}
