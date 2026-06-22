import 'package:flutter/material.dart';

import '../../../data/models/meal.dart';
import '../../../data/models/category.dart';
import '../../../data/repositories/meal_repository.dart';
import '../detail/detail_screen.dart';
import '../favorites/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MealRepository repository = MealRepository();

  final TextEditingController searchController = TextEditingController();

  Meal? randomMeal;
  List<Meal> meals = [];
  List<Category> categories = [];

  bool isLoadingRandom = false;
  bool isLoadingMeals = false;
  bool isLoadingCategories = false;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      fetchRandomMeal(),
      fetchCategories(),
      fetchDefaultMeals(),
    ]);
  }

  // Sugestão  de receita
  Future<void> fetchRandomMeal() async {
    setState(() => isLoadingRandom = true);

    final data = await repository.getRandomMeal();

    setState(() {
      randomMeal = data;
      isLoadingRandom = false;
    });
  }

  // Receitas padrão
  Future<void> fetchDefaultMeals() async {
    setState(() => isLoadingMeals = true);

    final data = await repository.searchMeal('chicken');

    setState(() {
      meals = data;
      isLoadingMeals = false;
    });
  }

  // Categorias
  Future<void> fetchCategories() async {
    setState(() => isLoadingCategories = true);

    final data = await repository.getCategories();

    setState(() {
      categories = data;
      isLoadingCategories = false;
    });
  }

  // Buscar receitas
  Future<void> searchMeals(String query) async {
    if (query.isEmpty) return;

    setState(() => isLoadingMeals = true);

    final data = await repository.searchMeal(query);

    setState(() {
      meals = data;
      isLoadingMeals = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text('Receitas'),
  actions: [
    IconButton(
      icon: const Icon(Icons.favorite),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FavoritesScreen(),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: fetchRandomMeal,
    ),
  ],
),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //pesquisar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar receita...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: searchMeals,
              ),

              const SizedBox(height: 20),

              // sugestão de receita
              const Text(
                'Sugestão de Receita',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              isLoadingRandom
                  ? const Center(child: CircularProgressIndicator())
                  : randomMeal == null
                      ? const SizedBox()
                      : _buildRandomMeal(randomMeal!),

              const SizedBox(height: 20),

              // CATEGORIAS
              const Text(
                'Tipo de comida',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              isLoadingCategories
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                searchMeals(category.name);
                              },
                              child: Chip(
                                label: Text(category.name),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              const SizedBox(height: 20),

              // LISTA DE RECEITAS
              const Text(
                'Receitas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              isLoadingMeals
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        final meal = meals[index];

                        return _buildMealCard(meal);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // CARD DA SUGESTÃO
  Widget _buildRandomMeal(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MealDetailScreen(meal: meal),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                meal.thumbnail,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CARD DAS RECEITAS
  Widget _buildMealCard(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MealDetailScreen(meal: meal),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: Image.network(
            meal.thumbnail,
            width: 60,
            fit: BoxFit.cover,
          ),
          title: Text(meal.name),
          subtitle: Text(meal.category),
        ),
      ),
    );
  }
}