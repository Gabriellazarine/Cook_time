import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite.dart';

class FavoriteService {
  static const String key = 'favorites_meals';

  Future<List<Favorite>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);

    return decoded.map((e) => Favorite.fromJson(e)).toList();
  }

  Future<void> saveFavorite(Favorite meal) async {
    final prefs = await SharedPreferences.getInstance();

    final current = await getFavorites();

    final exists = current.any((m) => m.idMeal == meal.idMeal);

    if (!exists) {
      current.add(meal);
    }

    await prefs.setString(
      key,
      jsonEncode(current.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> removeFavorite(String idMeal) async {
    final prefs = await SharedPreferences.getInstance();

    final current = await getFavorites();

    current.removeWhere((m) => m.idMeal == idMeal);

    await prefs.setString(
      key,
      jsonEncode(current.map((e) => e.toJson()).toList()),
    );
  }

  Future<bool> isFavorite(String idMeal) async {
    final list = await getFavorites();
    return list.any((m) => m.idMeal == idMeal);
  }
}