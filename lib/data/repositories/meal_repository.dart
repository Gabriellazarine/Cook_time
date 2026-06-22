import '../models/meal.dart';
import '../services/meal_service.dart';

class MealRepository {
  final MealService _service = MealService();

  Future<List<Meal>> getMeals() async {
    final data = await _service.getMeals();
    return data.map<Meal>((e) => Meal.fromJson(e)).toList();
  }
}