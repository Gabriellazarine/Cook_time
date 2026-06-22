import 'package:flutter/material.dart';
import '../../../data/models/meal.dart';
import '../../../data/models/favorite.dart';
import '../../../data/repositories/meal_repository.dart';

class MealDetailScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final repository = MealRepository();

  bool isFav = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    final result = await repository.isFavorite(widget.meal.idMeal);

    setState(() {
      isFav = result;
    });
  }

Future<void> toggleFavorite() async {
  final meal = widget.meal;

  final alreadyFav = await repository.isFavorite(meal.idMeal);

  if (alreadyFav) {
    await repository.removeFavorite(meal.idMeal);
  } else {
    await repository.addFavorite(
      Favorite(
        idMeal: meal.idMeal,
        name: meal.name,
        thumbnail: meal.thumbnail,
      ),
    );
  }

  final updated = await repository.isFavorite(meal.idMeal);

  setState(() {
    isFav = updated;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildInfoRow(),
                  const SizedBox(height: 16),
                  _buildIngredients(),
                  const SizedBox(height: 16),
                  _buildInstructions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // APP BAR COM FAVORITO
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.meal.thumbnail,
          fit: BoxFit.cover,
        ),
      ),

      actions: [
        IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: toggleFavorite,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.meal.name,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Chip(label: Text(widget.meal.category)),
        const SizedBox(width: 10),
        Chip(label: Text(widget.meal.area)),
      ],
    );
  }

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredientes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...widget.meal.ingredients.map(
          (item) => Text('• $item'),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Modo de preparo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.meal.instructions,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}