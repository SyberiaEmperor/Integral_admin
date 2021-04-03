import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/models/authentication.dart';
import 'package:integral_admin/models/user_data_repository.dart';
import 'package:integral_admin/utils/exceptions/auth_exceptions.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    UserDataRepository dataRepository,
    AuthenticationInterface loginService,
  )   : _urp = dataRepository,
        _loginService = loginService,
        super(
          AuthMainState(),
        ) {
    add(AuthFirstCheckEvent());
  }

  final UserDataRepository _urp;
  final AuthenticationInterface _loginService;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthInProgressState();
    if (event is AuthFirstCheckEvent) {
      AuthData? data = await _urp.getData();
      if (data != null) {
        yield await logIn(data);
      }
    }
    if (event is AuthLogInEvent) {
      yield await logIn(event.data);
    }
    yield AuthMainState();
  }

  Future<AuthState> logIn(AuthData data) async {
    try {
      await _loginService.logIn(data);
      unawaited(_urp.setData(data));
      return AuthLoggedInState();
    } on AuthException catch (exception) {
      return AuthErrorState(exception.message);
    } on Exception {
      rethrow;
    }
  }
}
