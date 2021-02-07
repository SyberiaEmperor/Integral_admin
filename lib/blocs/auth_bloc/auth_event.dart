part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogInEvent extends AuthEvent {
  final String login;
  final String password;

  AuthLogInEvent({@required this.login, @required this.password});
}

class AuthFirstCheckEvent extends AuthEvent {}
