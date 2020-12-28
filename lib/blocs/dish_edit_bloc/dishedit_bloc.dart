import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:meta/meta.dart';

part 'dishedit_event.dart';
part 'dishedit_state.dart';

class DisheditBloc extends Bloc<DisheditEvent, DisheditState> {
  Dish _dish;
  DisheditBloc(this._dish) : super(DishEditMainState(_dish));

  @override
  Stream<DisheditState> mapEventToState(
    DisheditEvent event,
  ) async* {
    bool successful = false;
    if (event is EditingDone) {
      yield DishEditLoadingState();
      try {
        //TODO: Implement actions
        _dish = (event as EditingDone).dish;
        successful = true;
      } on Exception {
        print('wooob');
      }
      yield EditingComplete(successful);
      yield DishEditMainState(_dish);
    }
  }
}
