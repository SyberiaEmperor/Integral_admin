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
  MainPageBloc({@required this.dishController}) : super(MainPageInitial()) {
    _currentCategory = Category.all;
    _currentDishes = dishController.byCategory(_currentCategory);
  }

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {}
}
