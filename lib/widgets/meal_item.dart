import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/models/meal.dart';
import 'package:fluttermax_navigation_and_multiple_screens/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String title, imgUrl, id;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  const MealItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  }) : super(key: key);
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
    Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
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
                Positioned(
                    child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    gradient: LinearGradient(colors: [
                      Colors.black.withAlpha(210),
                      Colors.black.withAlpha(0),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                )),
                Positioned(
                  bottom: 0,
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
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work_outline_rounded),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 6,
                      ),
                      Text('$duration min')
                    ],
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
