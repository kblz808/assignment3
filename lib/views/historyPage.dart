import 'package:assignment3/bloc/app_bloc.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatelessWidget {
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
    final state = context.read<AppBloc>().state as AppHistoryState;

    return Scaffold(
      appBar: AppBar(title: Text("history")),
      body: Center(
        child: Column(
          children: [
            for (List<Meal> lm in state.history)
              SizedBox(
                child: Column(
                  children: [
                    for (Meal m in lm) mealList(m),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
