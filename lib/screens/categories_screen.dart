import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/dummy_data.dart';
import 'package:fluttermax_navigation_and_multiple_screens/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Meals"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        children: kDummyCategories
            .map(
              (catData) =>
                  CategoryItem(title: catData.title, bgColor: catData.color),
            )
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
