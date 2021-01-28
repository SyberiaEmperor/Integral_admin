import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/services/requests.dart';
import 'package:meta/meta.dart';

part 'dishedit_event.dart';
part 'dishedit_state.dart';

class DisheditBloc<Mode extends DishEditMode>
    extends Bloc<DisheditEvent, DisheditState> {
  Dish _dish;
  DisheditBloc(this._dish) : super(DishEditMainState(_dish));

  @override
  Stream<DisheditState> mapEventToState(
    DisheditEvent event,
  ) async* {
    bool successful = false;
    if (event is DishEditingDone) {
      yield DishEditLoadingState();
      try {
        if (Mode == DishChange) {
          await Requests.putDish(event.dish);
        }
        if (Mode == DishCreate) {
          await Requests.postDish(event.dish);
        }
        //_dish = event.dish;
        successful = true;
      } on Exception {
        print('wooob');
      }
      yield DishEditingCompleteState(successful);
      yield DishEditMainState(_dish);
    }
  }
}
