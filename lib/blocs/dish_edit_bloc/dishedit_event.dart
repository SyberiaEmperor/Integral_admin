part of 'dishedit_bloc.dart';

@immutable
abstract class DisheditEvent {}

class DishEditingDone extends DisheditEvent {
  final Dish dish;
  DishEditingDone({@required this.dish});
}
