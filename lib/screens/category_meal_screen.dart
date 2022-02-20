import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/models/meal.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  const CategoryMealScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  String? categoryId;
  var _loadedAllMeals = false;
  late List<Meal> displayedMeals;
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_loadedAllMeals == false) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      categoryId = routeArgs['id'] as String;
      displayedMeals = kDummyMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedAllMeals = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // print("item $index is being rendered");
          final meal = displayedMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imgUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
            removeItemFunction: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
