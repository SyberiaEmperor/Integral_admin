part of 'dishedit_bloc.dart';

@immutable
abstract class DisheditEvent {}

class EditingDone {
  final Dish dish;
  EditingDone({@required this.dish});
}
