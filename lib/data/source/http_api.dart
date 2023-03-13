import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{
  static Future<Map<String, dynamic> > getRandomCocktail() async {
    final response = await http.post(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //return Album.fromJson(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}