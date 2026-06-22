import 'package:flutter/material.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/detail/detail_screen.dart';
import '../ui/screens/favorites/favorite_screen.dart';

class AppRoutes {
  static Route generate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/detail':
        return MaterialPageRoute(builder: (_) => const DetailScreen());

      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Rota não encontrada")),
          ),
        );
    }
  }
}