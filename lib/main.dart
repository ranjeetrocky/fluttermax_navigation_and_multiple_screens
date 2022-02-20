import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

const themeSeedColors = [
  Colors.pink,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.teal,
  Colors.blueGrey,
  Colors.purple
];
var currentPlatform = TargetPlatform.android;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _currentFilters = {
    'glutenFree': false,
    'vegan': false,
    'vegetarian': false,
    'lactoseFree': false,
  };
  List<Meal> _availableMeals = kDummyMeals;
  List<Meal> _favouriteMeals = [];
  void _setFilters(Map<String, bool> newFilterSettings) {
    setState(() {
      _currentFilters = newFilterSettings;
      _availableMeals = kDummyMeals.where((meal) {
        if ((_currentFilters['glutenFree'] as bool) && !meal.isGlutenFree) {
          return false;
        }
        if ((_currentFilters['vegan'] as bool) && !meal.isVegan) {
          return false;
        }
        if ((_currentFilters['vegetarian'] as bool) && !meal.isVegetarian) {
          return false;
        }
        if ((_currentFilters['lactoseFree'] as bool) && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  Color? _seedColor;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seedColor = themeSeedColors[Random().nextInt(7)];
  }

  void _changeColor() {
    setState(() {
      _seedColor = themeSeedColors[Random().nextInt(7)];
    });
  }

  void _changePlateform() {
    setState(() {
      if (currentPlatform == TargetPlatform.android) {
        currentPlatform = TargetPlatform.iOS;
      } else {
        currentPlatform = TargetPlatform.android;
      }
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      _favouriteMeals.add(kDummyMeals.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool _isFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Multiple Screen Demo',
      darkTheme: ThemeData(
        colorSchemeSeed: _seedColor,
        brightness: Brightness.dark,
        useMaterial3: true,
        cardTheme: const CardTheme(elevation: 20),
        platform: currentPlatform,
        // listTileTheme: const ListTileThemeData(textColor: Colors.black),
      ),
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        useMaterial3: true,
        cardTheme: const CardTheme(elevation: 20),
        colorSchemeSeed: _seedColor,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        platform: currentPlatform,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontFamily: 'Raleway'),
              headline5: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                // fontFamily: 'Raleway',
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
              headline4: const TextStyle(
                fontSize: 20,
                // fontFamily: 'Raleway',
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
      ),
      routes: {
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        TabsScreen.routeName: (context) => TabsScreen(
              favouriteMeals: _favouriteMeals,
              platform: currentPlatform,
              changeColor: _changeColor,
              changePlatform: _changePlateform,
            ),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              selectFavouriteFunction: _toggleFavourite,
              isFavourite: _isFavourite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              platform: currentPlatform,
              currentFilters: _currentFilters,
              saveFilterSettings: _setFilters,
              changePlatform: _changePlateform,
            ),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if(settings.name == '/meal-detail'){
        //   return ...;
        // }else if(settings.name == '/something-else'){
        //   return ...;
        // }
        //for dynamically generate routes in web
        return MaterialPageRoute(
          builder: (context) => TabsScreen(
            favouriteMeals: _favouriteMeals,
            platform: currentPlatform,
            changeColor: _changeColor,
            changePlatform: _changePlateform,
          ),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => TabsScreen(
            favouriteMeals: _favouriteMeals,
            platform: currentPlatform,
            changeColor: _changeColor,
            changePlatform: _changePlateform,
          ),
        );

        ///for making 404 page in flutter web
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
