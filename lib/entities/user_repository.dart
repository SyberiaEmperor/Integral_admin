import 'user.dart';

class UserRepository {
  static User _user;

  static void setUser(User user) {
    _user = user;
  }

  static User get user {
    return _user;
  }
}
