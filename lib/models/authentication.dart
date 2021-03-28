import 'package:integral_admin/entities/auth_data.dart';

abstract class AuthenticationInterface {
  Future<void> logIn(AuthData data);
}
