
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  Uri uri = Uri.parse('https://equran.id/api/v2/tafsir/1');
  var res = await http.get(uri);

    Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    print(data);
}
