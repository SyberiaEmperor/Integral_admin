import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/entities/user.dart';

abstract class AuthenticationInterface {
  Future<User> logIn(AuthData data);
}
