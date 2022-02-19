import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/dummy_data.dart';
import 'package:fluttermax_navigation_and_multiple_screens/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final VoidCallback changeColor;
  static const routeName = '/';
  const CategoriesScreen({Key? key, required this.changeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Meals",
          // style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Tooltip(
              message: 'Change Color',
              child: IconButton(
                  onPressed: changeColor,
                  icon: const Icon(Icons.refresh_rounded)))
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        children: kDummyCategories
            .map(
              (cat) => CategoryItem(
                title: cat.title,
                bgColor: cat.color,
                id: cat.id,
              ),
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
