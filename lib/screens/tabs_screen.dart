import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favourite_screen.dart';
import 'filters_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/';

  final VoidCallback changeColor;
  const TabsScreen({Key? key, required this.changeColor}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': const CategoriesScreen(), 'title': "Daily Meals"},
    {'page': const FavouriteScreen(), 'title': "Your Favourite"},
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: [
          Tooltip(
            message: 'Change Color',
            child: IconButton(
              onPressed: widget.changeColor,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: NavigationBarTheme(
        // data: Theme.of(context).navigationBarTheme.copyWith(
        //     indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        //     backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
        // data: Theme.of(context).navigationBarTheme,
        data: Theme.of(context).navigationBarTheme.copyWith(
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
        child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _selectedPageIndex,
            onDestinationSelected: _selectPage,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.restaurant_outlined),
                selectedIcon: Icon(Icons.restaurant_rounded),
                label: "Categories",
              ),
              NavigationDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: "Favourites",
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings_outlined),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        },
      ),
    );
  }
}
