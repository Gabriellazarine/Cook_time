class Meal {
  final String idMeal;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;

  final List<String> ingredients;

  Meal({
    required this.idMeal,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().isNotEmpty &&
          ingredient.toString() != 'null') {
        ingredients.add(
          '${measure ?? ''} ${ingredient}'.trim(),
        );
      }
    }

    return Meal(
      idMeal: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      ingredients: ingredients,
    );
  }
}