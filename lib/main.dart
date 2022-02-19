import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/categories_screen.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/category_meal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Multiple Screen Demo',
      theme: ThemeData(
        // primarySwatch: Colors.pink,
        colorSchemeSeed: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
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
            ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (context) => const CategoriesScreen(),
        '/category-meals': (context) => CategoryMealScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
