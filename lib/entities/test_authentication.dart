import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/entities/user.dart';
import 'package:integral_admin/models/authentication.dart';
import 'package:integral_admin/utils/auth_exceptions.dart';

class TestAuthentication extends AuthenticationInterface {
  @override
  Future<User> logIn(AuthData data) async {
    await Future.delayed(Duration(seconds: 3));
    if (data.password == '12345' && data.login == 'tester1') {
      return Future.value(User('test_token'));
    } else {
      return throw AuthException('Неккоректные данные');
    }
  }
}
