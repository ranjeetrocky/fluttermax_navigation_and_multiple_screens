import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  const FavouriteScreen({
    Key? key,
    required this.favouriteMeals,
  }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  void _removeFavMeal(String mealId) {
    setState(() {
      widget.favouriteMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favouriteMeals.isEmpty) {
      return const Center(
        child: Text("You have no faourites yet, Start Adding some!"),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // print("item $index is being rendered");
          final meal = widget.favouriteMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imgUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
            removeItemFunction: _removeFavMeal,
          );
        },
        itemCount: widget.favouriteMeals.length,
      );
    }
  }
}
