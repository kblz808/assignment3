import 'dart:convert';

import 'package:assignment3/bloc/app_bloc.dart';
import 'package:assignment3/bloc/app_event.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/dao/history_dao.dart';
import 'package:assignment3/models/meal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:assignment3/entity/history.dart';

class CartPage extends StatelessWidget {
  double calculateTotal(List<Meal> meals) {
    return meals.map((m) => m.price).fold<double>(0, (p, e) => p + e);
  }

  Future<void> saveCheckout(List<Meal> cart, HistoryDAO dao) async {
    final obj = serialize(cart);
    final history = History(items: obj);

    await dao.insertHistory(history);

    //print('saved to database');
  }

  String serialize(List<Meal> obj) {
    var result = "";
    obj.forEach(
      (element) {
        result += "${element.strMeal},";
      },
    );
    result += calculateTotal(obj).toStringAsPrecision(4);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppBloc>().state as AppCartState;
    final cart = state.cart;
    final dao = state.dao;

    return Scaffold(
      appBar: AppBar(
        title: const Text("cart"),
      ),
      floatingActionButton: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text("checkout"),
        ),
        onPressed: () async {
          saveCheckout(cart, dao);
          context.read<AppBloc>().add(AppReset());
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Text('${cart[index].strMeal}'),
                  ),
                  Text(cart[index].price.toStringAsPrecision(4)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
