part of 'dishedit_bloc.dart';

@immutable
abstract class DisheditState {}

class DishEditMainState extends DisheditState {
  final Dish dish;
  DishEditMainState(this.dish);
}

class DishEditingCompleteState extends DisheditState {
  final bool successful;
  final String caption;
  DishEditingCompleteState(this.successful,
      {this.caption = 'Возникла ошибка во время сохранения изменений.'});
}

class DishEditLoadingState extends DisheditState {}
