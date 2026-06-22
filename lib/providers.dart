import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/repositories/meal_repository.dart';
import 'data/models/meal.dart';

final mealRepositoryProvider = Provider(
  (ref) => MealRepository(),
);

final mealsProvider = FutureProvider<List<Meal>>((ref) async {
  final repo = ref.watch(mealRepositoryProvider);
  return repo.getMeals();
});

// FAVORITOS (simples em memória)
final favoritesProvider = StateProvider<List<Meal>>((ref) => []);