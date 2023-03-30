import 'package:equatable/equatable.dart';
import 'package:assignment3/models/meal.dart';

import 'package:assignment3/dao/history_dao.dart';

abstract class AppEvent extends Equatable {}

class AppAddToCartEvent extends AppEvent {
  final Meal meal;

  AppAddToCartEvent(this.meal);

  @override
  List<Object> get props => [];
}

class AppCheckHistoryEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppFetchData extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppReset extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppNormal extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppReadCart extends AppEvent {
  final List<Meal> cart;
  final HistoryDAO dao;

  AppReadCart({required this.cart, required this.dao});

  @override
  List<Object> get props => [];
}

class AppReadHistroy extends AppEvent {
  final HistoryDAO dao;

  AppReadHistroy(this.dao);
  @override
  List<Object> get props => [];
}
