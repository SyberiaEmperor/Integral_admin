import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/models/dish_controller.dart';
import 'package:meta/meta.dart';

part 'mainpage_event.dart';
part 'mainpage_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final DishController dishController;
  List<Dish> _currentDishes;
  Category _currentCategory;
  MainPageBloc({@required this.dishController}) : super(LoadingState()) {
    _currentCategory = Category.all;
    add(Update());
  }

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    yield LoadingState();
    if (event is Update) {
      {
        await dishController.updateDishes();
        _currentDishes = dishController.byCategory(_currentCategory);
      }
    } else if (event is ChangeCategoryEvent) {
      _currentCategory = event.category;
      _currentDishes = dishController.byCategory(_currentCategory);
    } else if (event is SearchEvent) {
      _currentDishes = dishController.search(event.text);
    }
    yield MainPageInitialState(
        dishes: _currentDishes, category: _currentCategory);
  }
}
