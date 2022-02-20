import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/models/meal.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/meal_detail_screen.dart';

typedef RemoveItemFunctionBluePrint = void Function(String mealId);

class MealItem extends StatelessWidget {
  final String title, imgUrl, id;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final RemoveItemFunctionBluePrint? removeItemFunction;

  const MealItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.imgUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.removeItemFunction})
      : super(key: key);
  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
    }
  }

  void _selectMeal(context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((value) {
      if (value != null) {
        removeItemFunction!(value as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => _selectMeal(context),
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: id,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imgUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, imageChunkEvent) {
                          // print(imageChunkEvent?.expectedTotalBytes!.toString());
                          // print("\n" +
                          //     (imageChunkEvent?.cumulativeBytesLoaded).toString());
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   print("bruh");
                          // });
                          return imageChunkEvent == null
                              ? child
                              : SizedBox(
                                  height: 250,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 1,
                                      semanticsLabel: "Loading",
                                      value: (imageChunkEvent
                                              .cumulativeBytesLoaded /
                                          imageChunkEvent.expectedTotalBytes!),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Colors.black.withAlpha(210),
                      Colors.black.withAlpha(0),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                )),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 382.8,
                    // width: 382.8,
                    // width: constraints.maxWidth,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      // maxLines: 1,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MealItemDataLabel(
                    icon: Icons.attach_money,
                    label: affordabilityText,
                  ),
                  MealItemDataLabel(
                    icon: Icons.work_outline_rounded,
                    label: complexityText,
                  ),
                  MealItemDataLabel(
                    icon: Icons.schedule,
                    label: '$duration min',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealItemDataLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const MealItemDataLabel({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 6,
        ),
        Text(label)
      ],
    );
  }
}
