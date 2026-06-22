import '../services/meal_service.dart';
import '../models/meal.dart';
import '../models/category.dart';
import '../models/favorite.dart';
import '../services/favorite_service.dart';

class MealRepository {
  final MealService _service = MealService();

  // Sugestão de receita
  Future<Meal> getRandomMeal() async {
    final data = await _service.getRandomMeal();
    return Meal.fromJson(data);
  }

  // Buscar receitas por nome
  Future<List<Meal>> searchMeal(String query) async {
    final data = await _service.searchMeal(query);

    return (data as List)
        .map((item) => Meal.fromJson(item))
        .toList();
  }

  // Categorias
  Future<List<Category>> getCategories() async {
    final data = await _service.getCategories();

    return (data as List)
        .map((item) => Category.fromJson(item))
        .toList();
  }

  // Receitas por categoria
  Future<List<Meal>> getMealsByCategory(String category) async {
    final data = await _service.getMealsByCategory(category);

    return (data as List)
        .map((item) => Meal.fromJson(item))
        .toList();
  }

final FavoriteService _favoriteService = FavoriteService();

  Future<List<Favorite>> getFavorites() {
    return _favoriteService.getFavorites();
  }

  Future<void> addFavorite(Favorite meal) {
    return _favoriteService.saveFavorite(meal);
  }

  Future<void> removeFavorite(String idMeal) {
    return _favoriteService.removeFavorite(idMeal);
  }

  Future<bool> isFavorite(String idMeal) {
    return _favoriteService.isFavorite(idMeal);
  }


}

  