import '../data/models/favorite.dart';
import '../data/repositories/meal_repository.dart';

class FavoritesViewModel {
  final MealRepository repository;

  FavoritesViewModel(this.repository);

  Future<List<Favorite>> loadFavorites() {
    return repository.getFavorites();
  }

  Future<void> toggleFavorite(Favorite meal) async {
    final isFav = await repository.isFavorite(meal.idMeal);

    if (isFav) {
      await repository.removeFavorite(meal.idMeal);
    } else {
      await repository.addFavorite(meal);
    }
  }

  Future<bool> isFavorite(String idMeal) {
    return repository.isFavorite(idMeal);
  }
}