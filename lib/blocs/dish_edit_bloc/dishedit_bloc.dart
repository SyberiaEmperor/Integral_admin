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
    bool successful = true;
    String caption = '';
    if (event is DishEditingDone) {
      yield DishEditLoadingState();

      try {
        if (!checkFields(event.dish)) {
          throw WrongFieldException('Некорректные поля');
        }

        if (Mode == DishChange) {
          await Requests.putDish(event.dish);
        }
        if (Mode == DishCreate) {
          await Requests.postDish(event.dish);
        }
        //_dish = event.dish;
        //successful = true;
      } on RequestException catch (e) {
        successful = false;
        caption = e.message;
      } on WrongFieldException catch (e) {
        successful = false;
        caption = e.message;
      }

      yield DishEditingCompleteState(successful, caption: caption);
      yield DishEditMainState(_dish);
    }
  }

  bool checkFields(Dish dish) {
    bool result = true;
    result = result && (dish.price != null && dish.price > 0);
    result = result && (dish.name != null && dish.name.isNotEmpty);
    result = result && dish.categories.isNotEmpty;

    return result;
  }
}

class WrongFieldException implements Exception {
  final String message;

  WrongFieldException(this.message);
}
