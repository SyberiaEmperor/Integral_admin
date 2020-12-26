import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dishedit_event.dart';
part 'dishedit_state.dart';

class DisheditBloc extends Bloc<DisheditEvent, DisheditState> {
  DisheditBloc() : super(DisheditInitial());

  @override
  Stream<DisheditState> mapEventToState(
    DisheditEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
