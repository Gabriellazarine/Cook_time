import 'dart:convert';
import 'package:http/http.dart' as http;

class MealService {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<dynamic>> getMeals() async {
    final url = Uri.parse("$baseUrl/search.php?s=");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['meals'];
    }

    throw Exception("Erro ao buscar receitas");
  }
}