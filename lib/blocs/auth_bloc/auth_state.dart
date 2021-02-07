part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthMainState extends AuthState {}

class AuthInProgressState extends AuthState {}

class AuthErrorState extends AuthState {
  final String caption;

  AuthErrorState(this.caption);
}

class AuthLoggedInState extends AuthState {}
