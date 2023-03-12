import 'package:assignment3/models/meal.dart';
import 'package:equatable/equatable.dart';

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

  AppCartState(this.cart);

  @override
  List<Object> get props => [];
}

class AppHistoryState extends AppState {
  final List<List<Meal>> history;

  AppHistoryState(this.history);

  @override
  List<Object> get props => [];
}
