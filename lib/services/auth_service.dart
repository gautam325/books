import 'package:books/model/app_user.dart';

class AuthService {
  Future<AppUser> login(String email, String password) async {
    return AppUser(name: 'Gautam', email: email);
  }

  Future<AppUser> register(String name, String email, String password) async {
    return AppUser(name: name, email: email);
  }
}
