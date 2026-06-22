import 'dart:convert';
import 'package:http/http.dart' as http;

class MealService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Sugestão de Receita
  Future<dynamic> getRandomMeal() async {
    final response = await http.get(
      Uri.parse('$baseUrl/random.php'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'][0];
    }

    throw Exception('Erro ao buscar receita aleatória');
  }

  // Buscar por nome
  Future<dynamic> searchMeal(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search.php?s=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'] ?? [];
    }

    throw Exception('Erro ao buscar receitas');
  }

  // Categorias
  Future<dynamic> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['categories'];
    }

    throw Exception('Erro ao buscar categorias');
  }

  // Receitas por categoria
  Future<dynamic> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?c=$category'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['meals'] ?? [];
    }

    throw Exception('Erro ao buscar receitas por categoria');
  }
}