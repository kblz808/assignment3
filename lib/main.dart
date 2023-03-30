import 'package:assignment3/bloc/app_event.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/views/cartPage.dart';
import 'package:assignment3/views/historyPage.dart';
import 'package:flutter/material.dart';

import 'package:assignment3/models/meal.dart';
import 'package:assignment3/views/mealCard.dart';
import 'package:assignment3/bloc/app_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:assignment3/database/database.dart';
import 'package:assignment3/dao/history_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('history_database.db').build();
  final dao = database.historyDAO;

  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  final HistoryDAO dao;

  const MyApp({required this.dao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/cart': (context) => CartPage(),
          '/history': (context) => HistoryPage(),
        },
        home: HomePage(dao: dao),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final HistoryDAO dao;
  const HomePage({Key? key, required this.dao}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<Meal>> _mealsHistory = [];
  final List<Meal> _cart = [];
  List<Meal?> meals = [];

  void reset() {
    _cart.clear();
    fetchData();
  }

  void fetchData() {
    context.read<AppBloc>().add(AppFetchData());
  }

  void goToCart() {
    context.read<AppBloc>().add(AppReadCart(cart: _cart, dao: widget.dao));
    Navigator.pushNamed(context, '/cart');
  }

  void goToHistory() {
    // context.read<AppBloc>().add(AppReadHistroy(_mealsHistory, dao));
    context.read<AppBloc>().add(AppReadHistroy(widget.dao));
    Navigator.pushNamed(context, '/history');
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;
    if (state is AppAddToCartState) {
      setState(() {
        _cart.add(state.meal);
        context.read<AppBloc>().add(AppNormal());
      });
    } else if (state is AppCartState) {
      _mealsHistory.add(state.cart);
    } else if (state is AppResetState) {
      reset();
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        elevation: 0,
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AppInitialState) {
            return Center(
              child: ElevatedButton(
                onPressed: fetchData,
                child: const Text("fetch data"),
              ),
            );
          } else if (state is AppSuccessState) {
            meals = state.meals;
            return SizedBox(
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) => MealCard(meals[index]!),
              ),
            );
          }
          return SizedBox(
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => MealCard(meals[index]!),
            ),
          );
        },
      ),
      //
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: goToCart,
                  icon: const Icon(Icons.shopping_bag),
                  iconSize: 30,
                ),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.fromLTRB(1, 5, 0, 0),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffc32c37),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Text(
                          "${_cart.length}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: goToHistory,
              icon: const Icon(Icons.history),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
              iconSize: 30,
            )
          ],
        ),
      ),
    );
  }
}
