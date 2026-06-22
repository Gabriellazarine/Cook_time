import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("⭐ Favoritos")),
      body: favorites.isEmpty
          ? const Center(child: Text("Nenhuma receita favorita"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final meal = favorites[index];

                return ListTile(
                  title: Text(meal.name),
                );
              },
            ),
    );
  }
}