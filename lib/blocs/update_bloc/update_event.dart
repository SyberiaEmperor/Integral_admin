part of 'update_bloc.dart';

@immutable
abstract class UpdateEvent {}

class RunUpdate extends UpdateEvent {
  RunUpdate._();
}
