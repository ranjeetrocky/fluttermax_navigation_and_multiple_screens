import 'package:flutter/material.dart';

class CategoryMealScreen extends StatelessWidget {
  final String id, title;
  const CategoryMealScreen({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text("The Recipes for the Category!"),
      ),
    );
  }
}
