import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/widgets/meal_item.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favourite_screen.dart';
import 'filters_screen.dart';
import 'package:awesome_icons/awesome_icons.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/';

  final VoidCallback changeColor, changePlatform;
  final TargetPlatform platform;
  final List<Meal> favouriteMeals;
  const TabsScreen({
    Key? key,
    required this.changeColor,
    required this.changePlatform,
    required this.platform,
    required this.favouriteMeals,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _isPlatformChanged = false;
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': const CategoriesScreen(), 'title': "Daily Meals"},
      {
        'page': FavouriteScreen(
          favouriteMeals: widget.favouriteMeals,
        ),
        'title': "Your Favourite"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    _isPlatformChanged =
        widget.platform == TargetPlatform.android ? false : true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages?[_selectedPageIndex]['title'] as String),
        actions: [
          Tooltip(
            message: 'Change Color',
            child: IconButton(
              onPressed: widget.changeColor,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
          Tooltip(
            message: _isPlatformChanged ? 'Change to Android' : 'Change to iOS',
            child: IconButton(
              onPressed: () {
                widget.changePlatform();
                setState(() {
                  _isPlatformChanged = !_isPlatformChanged;
                });
              },
              icon: Icon(
                _isPlatformChanged
                    ? FontAwesomeIcons.android
                    : FontAwesomeIcons.apple,
              ),
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: _pages?[_selectedPageIndex]['page'] as Widget,
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
                selectedIcon: Icon(FontAwesomeIcons.utensils),
                label: "Categories",
              ),
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.heart),
                selectedIcon: Icon(FontAwesomeIcons.solidHeart),
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
