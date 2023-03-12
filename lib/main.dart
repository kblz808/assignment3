import 'package:flutter/material.dart';

import 'package:assignment3/services/apiService.dart';
import 'package:assignment3/models/meal.dart';
import 'package:assignment3/views/mealCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _meals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("home")),
      body: StreamBuilder(
        stream: ApiServiceProvider().fetchData(),
        builder: (context, AsyncSnapshot<Meal?> snapshot) {
          if (snapshot.hasData) {
            _meals.add(MealCard(snapshot.data!));
          }
          return ListView.builder(
            itemCount: _meals.length,
            itemBuilder: (context, index) => _meals[index],
          );
        },
      ),
    );
  }
}
