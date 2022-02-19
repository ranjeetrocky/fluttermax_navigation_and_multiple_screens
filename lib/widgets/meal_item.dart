import 'package:flutter/material.dart';
import 'package:fluttermax_navigation_and_multiple_screens/models/meal.dart';

class MealItem extends StatelessWidget {
  final String title, imgUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  const MealItem({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  }) : super(key: key);
  void _selectMeal() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: _selectMeal,
        borderRadius: BorderRadius.circular(15),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
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
                                value: (imageChunkEvent.cumulativeBytesLoaded /
                                    imageChunkEvent.expectedTotalBytes!),
                              ),
                            ),
                          );
                  },
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
