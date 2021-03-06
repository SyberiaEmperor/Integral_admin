import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/controllers/dish_changer.dart';

import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/models/dish_edit_modes.dart';
import 'package:integral_admin/services/requests.dart';
import 'package:meta/meta.dart';

part 'dishedit_event.dart';
part 'dishedit_state.dart';

class DisheditBloc<Mode extends DishEditMode>
    extends Bloc<DisheditEvent, DisheditState> {
  // ignore: prefer_final_fields
  Dish? _dish;
  final DishChanger controller;
  DisheditBloc(this._dish, this.controller) : super(DishEditMainState(_dish));

  @override
  Stream<DisheditState> mapEventToState(
    DisheditEvent event,
  ) async* {
    bool successful = true;
    String caption = '';
    try {
      if (event is DishEditingDone) {
        yield DishEditLoadingState();
        if (!checkFields(event.dish)) {
          throw WrongFieldException('Некорректные поля');
        }
        if (Mode == DishChange) {
          await controller.update(event.dish);
        }
        if (Mode == DishCreate) {
          await controller.create(event.dish);
        }
      }
      if (event is DishDelete) {
        await controller.delete();
      }
    } on RequestException catch (e) {
      successful = false;
      caption = e.message;
    } on WrongFieldException catch (e) {
      successful = false;
      caption = e.message;
    } finally {
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
