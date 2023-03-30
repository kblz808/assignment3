import 'package:bloc/bloc.dart';

import 'package:assignment3/bloc/app_event.dart';
import 'package:assignment3/bloc/app_state.dart';
import 'package:assignment3/services/apiService.dart';
import 'package:assignment3/models/meal.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final _serviceProvider = ApiServiceProvider();

  AppBloc() : super(AppInitialState()) {
    on<AppEvent>(
      (event, emit) async {
        if (event is AppFetchData) {
          emit(AppLoadingState());
          try {
            final List<Meal?> meals = [];
            final mealsStream = _serviceProvider.fetchData();
            await for (Meal? meal in mealsStream) {
              meals.add(meal);
            }
            emit(AppSuccessState(meals));
          } catch (e) {
            emit(AppErrorState('error fetching data'));
          }
        } else if (event is AppAddToCartEvent) {
          emit(AppAddToCartState(event.meal));
        } else if (event is AppNormal) {
          emit(AppNormalState());
        } else if (event is AppReadCart) {
          emit(AppCartState(cart: event.cart, dao: event.dao));
        } else if (event is AppReadHistroy) {
          emit(AppHistoryState(event.dao));
        } else if (event is AppReset) {
          emit(AppResetState());
        }
      },
    );
  }
}
