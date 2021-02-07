import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/models/user_data_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(UserDataRepository dataRepository)
      : _urp = dataRepository,
        super(AuthMainState());

  final UserDataRepository _urp;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthFirstCheckEvent)
      Map<String, String> data = await _urp.getData();
  }
}
