// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<String> listyResponse(String text) async {

//   var url = Uri.https("api.openai.com", "/v1/completions");
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       "Authorization": "Bearer $apiKey"
//     },
//     body: json.encode({
//       "model": "text-davinci-003",
//       "prompt": "lorsque c'est necessaire, ameliore la présentation avec des paragraphes, ajoute des listes avec des tirets et une correction d'orthographe: $text",
//       'temperature': 0,
//       'max_tokens': 2000,
//       'top_p': 1,
//       'frequency_penalty': 0.0,
//       'presence_penalty': 0.0,
//     }),
//   );

//   Map<String, dynamic> newresponse = jsonDecode(response.body);

//   return newresponse['choices'][0]['text']
//       .toString()
//       .replaceAll("©", "é")
//       .replaceAll("Ã", "")
//       .replaceAll("ª", "ê")
//       .replaceAll("```", "")
//       .replaceFirst("\n", "")
//       .replaceFirst("\n", "")
//       .replaceAll(" ", "")
//       .replaceAll("¨", "è")
//       .replaceAll("§", "ç")
//       .replaceAll(".", ".")
//       .replaceAll("  ", " ")
//       .replaceAll("", "a")
//       .replaceAll("Å", "p")
//       .replaceAll("Â", "")
//       .replaceAll("", "é")
//       .replaceAll("¢", "â");
// }
