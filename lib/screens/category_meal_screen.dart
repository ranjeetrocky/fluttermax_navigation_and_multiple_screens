import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    var categoryTitle = routeArgs['title'] as String;
    var categoryId = routeArgs['id'] as String;
    final categoryMeals = kDummyMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final meal = categoryMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imgUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
