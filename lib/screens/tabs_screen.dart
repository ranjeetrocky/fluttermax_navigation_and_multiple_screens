import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favourite_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/';

  final VoidCallback changeColor;
  const TabsScreen({Key? key, required this.changeColor}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily Meals'),
          actions: [
            Tooltip(
                message: 'Change Color',
                child: IconButton(
                    onPressed: widget.changeColor,
                    icon: const Icon(Icons.refresh_rounded)))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.restaurant_menu_outlined),
                  text: 'Categories'),
              Tab(icon: Icon(Icons.star_border), text: 'Favourites')
            ],
          ),
        ),
        body: const TabBarView(children: [
          CategoriesScreen(),
          FavouriteScreen(),
        ]),
      ),
    );
  }
}
