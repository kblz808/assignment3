import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment3/models/meal.dart';

class ApiServiceProvider {
  final int amount = 5;
  Stream<Meal?> fetchData() async* {
    for (int i = 0; i < amount; i++) {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   'Accept': 'application/json',
        // },
      );

      if (response.statusCode == 200) {
        final parsed = Meal.fromJson(json.decode(response.body)['meals'][0]);
        // print(parsed.strMeal);
        yield parsed;
      } else {
        print("error on api");
        throw Exception("error");
      }
    }
  }
}
