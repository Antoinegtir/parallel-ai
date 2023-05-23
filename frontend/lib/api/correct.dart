import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> correctStr(String text) async {
  final url = Uri.parse(
      'https://parallelsai.onrender.com/line_orthograph?to_process=$text');
  final response = await http.get(url);
  final dynamic jsonData = json.decode(response.body);
  if (response.statusCode == 200) {
    return jsonData["message"];
  } else {
    return text;
  }
}
