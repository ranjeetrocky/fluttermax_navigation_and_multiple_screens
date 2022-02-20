import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/categories_screen.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/filters_screen.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            // color: Theme.of(context).accentColor,
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                // color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _drawerButton(
              context: context,
              btnText: "Meals",
              icon: Icons.restaurant,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              }),
          _drawerButton(
              context: context,
              btnText: "Settings",
              icon: Icons.settings,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }),
        ],
      ),
    );
  }

  ListTile _drawerButton({
    required BuildContext context,
    required String btnText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        // color: Theme.of(context).primaryColor,
        size: 26,
      ),
      title: Text(
        btnText,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
