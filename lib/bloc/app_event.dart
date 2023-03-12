import 'package:equatable/equatable.dart';
import 'package:assignment3/models/meal.dart';

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

class AppReadCart extends AppEvent {
  final List<Meal> cart;

  AppReadCart(this.cart);

  @override
  List<Object> get props => [];
}

class AppReadHistroy extends AppEvent {
  final List<List<Meal>> history;

  AppReadHistroy(this.history);
  @override
  List<Object> get props => [];
}
