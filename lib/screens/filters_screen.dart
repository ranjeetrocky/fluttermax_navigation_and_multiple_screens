import 'dart:io';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/tabs_screen.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = "/filters-screen";
  final Function saveFilterSettings;
  final VoidCallback changePlatform;
  final TargetPlatform platform;
  final Map<String, bool> currentFilters;
  const FiltersScreen(
      {Key? key,
      required this.saveFilterSettings,
      required this.currentFilters,
      required this.changePlatform,
      required this.platform})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

typedef ToggleSwitchFunction = void Function(bool newValue);

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;
  var _isPlatformChanged = false;
  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters['glutenFree'] as bool;
    _isVegan = widget.currentFilters['vegan'] as bool;
    _isVegetarian = widget.currentFilters['vegetarian'] as bool;
    _isLactoseFree = widget.currentFilters['lactoseFree'] as bool;
  }

  Widget _settingListTile({
    required String titleText,
    required String description,
    required bool value,
    required ToggleSwitchFunction updateValue,
  }) {
    return SwitchListTile.adaptive(
      title: Text(titleText),
      subtitle: Text(description),
      value: value,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    _isPlatformChanged =
        widget.platform == TargetPlatform.android ? false : true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              widget.saveFilterSettings({
                'glutenFree': _isGlutenFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
                'lactoseFree': _isLactoseFree,
              });
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
            icon: const Icon(Icons.save_outlined),
          ),
          Tooltip(
            message: _isPlatformChanged ? 'Change to Android' : 'Change to iOS',
            child: IconButton(
              onPressed: () {
                widget.changePlatform();
                setState(
                  () {
                    _isPlatformChanged = !_isPlatformChanged;
                  },
                );
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Select Filter",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Column(
            children: [
              _settingListTile(
                titleText: "Gluten Free",
                description: "Only Show Gluten Free Meals",
                value: _isGlutenFree,
                updateValue: (newValue) {
                  setState(
                    () {
                      _isGlutenFree = newValue;
                    },
                  );
                },
              ),
              _settingListTile(
                titleText: "Vegan",
                description: "Only Show Vegan Meals",
                value: _isVegan,
                updateValue: (newValue) {
                  setState(
                    () {
                      _isVegan = newValue;
                    },
                  );
                },
              ),
              _settingListTile(
                titleText: "Vegeterian",
                description: "Only Show Vegeterian Meals",
                value: _isVegetarian,
                updateValue: (newValue) {
                  setState(
                    () {
                      _isVegetarian = newValue;
                    },
                  );
                },
              ),
              _settingListTile(
                titleText: "Lactose Free",
                description: "Only Show Lactose Free Meals",
                value: _isLactoseFree,
                updateValue: (newValue) {
                  setState(
                    () {
                      _isLactoseFree = newValue;
                    },
                  );
                },
              ),
            ],
          ),
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.save),
            label: const Text(
              "Save & Exit",
              style: TextStyle(fontSize: 20, fontFamily: "RobotoCondensed"),
            ),
            onPressed: () {
              widget.saveFilterSettings({
                'glutenFree': _isGlutenFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
                'lactoseFree': _isLactoseFree,
              });
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
