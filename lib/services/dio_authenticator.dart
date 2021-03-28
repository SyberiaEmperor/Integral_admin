import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/models/authentication.dart';
import 'package:integral_admin/services/requests.dart';

class DioAuthenticator implements AuthenticationInterface {
  @override
  Future<void> logIn(AuthData data) {
    try {
      return Requests.logIn(data);
    } on RequestException {
      rethrow;
    }
  }
}
