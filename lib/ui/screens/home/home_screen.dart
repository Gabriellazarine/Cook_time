import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers.dart';
import '../../widgets/meal_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(mealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("🍔 Receitas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          )
        ],
      ),
      body: mealsAsync.when(
        data: (meals) {
          return GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];

              return MealCard(
                meal: meal,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: meal,
                  );
                },
              );
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text("Erro: $e"),
      ),
    );
  }
}