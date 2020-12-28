part of 'dishedit_bloc.dart';

@immutable
abstract class DisheditState {}

class DishEditMainState extends DisheditState {
  final Dish dish;
  DishEditMainState(this.dish);
}

class EditingComplete extends DisheditState {
  final bool successful;

  EditingComplete(this.successful);
}

class DishEditLoadingState extends DisheditState {}
