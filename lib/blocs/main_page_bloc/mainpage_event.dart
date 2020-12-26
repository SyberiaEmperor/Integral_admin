part of 'mainpage_bloc.dart';

@immutable
abstract class MainPageEvent {}

class Update extends MainPageEvent {}

class SearchEvent extends MainPageEvent {
  final String text;

  SearchEvent(this.text);
}

class ChangeCategoryEvent extends MainPageEvent {
  final Category category;

  ChangeCategoryEvent(this.category);
}
