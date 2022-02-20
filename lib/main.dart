import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
const platform = TargetPlatform.iOS;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Multiple Screen Demo',
      darkTheme: ThemeData(
        colorSchemeSeed: _seedColor,
        brightness: Brightness.dark,
        useMaterial3: true,
        cardTheme: const CardTheme(elevation: 20),
        platform: platform,
        // listTileTheme: const ListTileThemeData(textColor: Colors.black),
      ),
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        useMaterial3: true,
        cardTheme: const CardTheme(elevation: 20),
        colorSchemeSeed: _seedColor,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        platform: platform,
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
        TabsScreen.routeName: (context) =>
            TabsScreen(changeColor: _changeColor),
        CategoryMealScreen.routeName: (context) => const CategoryMealScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen(),
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
          builder: (context) => TabsScreen(changeColor: _changeColor),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => TabsScreen(changeColor: _changeColor),
        );

        ///for making 404 page in flutter web
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
