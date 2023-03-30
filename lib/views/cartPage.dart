import 'package:assignment3/bloc/app_bloc.dart';
import 'package:assignment3/bloc/app_event.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/models/meal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  double calculateTotal(List<Meal> meals) {
    return meals.map((m) => m.price).fold<double>(0, (p, e) => p + e);
  }

  Widget mealList(Meal meal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(meal.strMeal!),
        Text(meal.price.toString()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppBloc>().state as AppCartState;

    return Scaffold(
      appBar: AppBar(
        title: const Text("cart"),
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                for (Meal st in state.cart) mealList(st),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("total price: "),
                Text("${calculateTotal(state.cart)}"),
                ElevatedButton(
                  child: Text("checkout"),
                  onPressed: () {},
                  //onPressed: () => context.read<AppBloc>().add(AppResetState()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
