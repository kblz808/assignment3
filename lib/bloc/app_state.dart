import 'package:assignment3/models/meal.dart';
import 'package:equatable/equatable.dart';

import 'package:assignment3/dao/history_dao.dart';

abstract class AppState extends Equatable {}

class AppInitialState extends AppState {
  @override
  List<Object> get props => [];
}

class AppLoadingState extends AppState {
  @override
  List<Object> get props => [];
}

class AppSuccessState extends AppState {
  final List<Meal?> meals;

  AppSuccessState(this.meals);

  @override
  List<Object> get props => [];
}

class AppErrorState extends AppState {
  final String error;

  AppErrorState(this.error);

  @override
  List<Object> get props => [];
}

class AppAddToCartState extends AppState {
  final Meal meal;

  AppAddToCartState(this.meal);

  @override
  List<Object> get props => [];
}

class AppNormalState extends AppState {
  @override
  List<Object> get props => [];
}

class AppCartState extends AppState {
  final List<Meal> cart;
  final HistoryDAO dao;

  AppCartState({required this.cart, required this.dao});

  @override
  List<Object> get props => [];
}

class AppHistoryState extends AppState {
  final HistoryDAO dao;

  AppHistoryState(this.dao);

  @override
  List<Object> get props => [];
}

class AppResetState extends AppState {
  @override
  List<Object> get props => [];
}
