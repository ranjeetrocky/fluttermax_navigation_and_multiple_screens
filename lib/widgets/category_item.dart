import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title, id;
  final Color bgColor;
  const CategoryItem(
      {Key? key, required this.title, required this.bgColor, required this.id})
      : super(key: key);

  void _selectCategory(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => CategoryMealScreen(id: id, title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      // overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bgColor.withOpacity(0.7),
              bgColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
