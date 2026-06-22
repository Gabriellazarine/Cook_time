import 'package:flutter/material.dart';
import '../../../data/models/favorite.dart';
import '../../../data/repositories/meal_repository.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final MealRepository repository = MealRepository();

  List<Favorite> favorites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final data = await repository.getFavorites();

    setState(() {
      favorites = data;
      loading = false;
    });
  }

  Future<void> removeFavorite(String id) async {
    await repository.removeFavorite(id);
    await loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? const Center(child: Text('Nenhuma receita favoritada'))
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];

                    return ListTile(
                      leading: Image.network(
                        item.thumbnail,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => removeFavorite(item.idMeal),
                      ),
                    );
                  },
                ),
    );
  }
}