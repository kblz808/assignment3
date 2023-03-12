import 'package:flutter/material.dart';
import 'package:assignment3/models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(meal.strMealThumb ?? " "),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // info
          Text(meal.strMeal!),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${meal.price}\$"),
              const ElevatedButton(
                onPressed: null,
                child: Text("add to cart"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
