part of 'mainpage_bloc.dart';

@immutable
abstract class MainPageState {}

class MainPageInitialState extends MainPageState {
  final List<Dish> dishes;
  final Category category;

  MainPageInitialState({@required this.dishes, @required this.category});
}

class LoadingState extends MainPageState {}
