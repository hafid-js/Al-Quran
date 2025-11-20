
// import 'dart:convert';

// import 'package:http/http.dart' as http;

// void main() async {

//     for (int i = 1; i <= 30; i++) {
//   Uri uri = Uri.parse('https://api.alquran.cloud/v1/juz/$i');
//     var res = await http.get(uri);

//       Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];
//       print(data);
//     }
// }


// Future<List<Juz>> getAllJuz() async {

//     List<Juz> allJuz = [];

//     for (int i = 1; i <= 30; i++) {
//  Uri uri = Uri.parse('https://api.alquran.cloud/v1/juz/$i');
//     var res = await http.get(uri);

//       Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>)["data"];

//       Juz juz = Juz.fromJson(data);

//       allJuz.add(juz);
//     }

//     return allJuz;
   
//   }
