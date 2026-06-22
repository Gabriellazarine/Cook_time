import 'package:flutter/material.dart';
import '../../../data/models/meal.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Meal meal =
        ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(meal.image),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(meal.instructions),
            ),
          ],
        ),
      ),
    );
  }
}