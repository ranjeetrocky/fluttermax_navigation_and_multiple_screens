import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = "/filters-screen";
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

typedef ToggleSwitchFunction = void Function(bool newValue);

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      drawer: const MainDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
          )
        ],
      ),
    );
  }
}
