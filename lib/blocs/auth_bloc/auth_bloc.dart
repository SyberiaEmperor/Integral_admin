import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/models/authentification.dart';
import 'package:integral_admin/models/user_data_repository.dart';
import 'package:integral_admin/utils/auth_exceptions.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      UserDataRepository dataRepository, AuthentificationInterface loginService)
      : _urp = dataRepository,
        _loginService = loginService,
        super(AuthMainState());

  final UserDataRepository _urp;
  final AuthentificationInterface _loginService;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthFirstCheckEvent) {
      AuthData data = await _urp.getData();
      if (data != null) {
        try {
          await _loginService.logIn(data);
        } on AuthException catch (exception) {
          yield AuthErrorState(exception.message);
        } on Exception {
          rethrow;
        }
      }
    }
  }
}
