import 'package:teamy/imports.dart';
class AuthService {
  final IAuthRepo repo;
  AuthService(this.repo);

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final user = await repo.signIn(email, password);
    if (user == null) {
      return {'success': false, 'message': 'Invalid credentials'};
    }
    return {'success': true, 'data': user.toJson()};
  }

  Future<Map<String, dynamic>> signUp(String email, String password, String name) async {
    final user = await repo.signUp(email, password, name);
    if (user == null) {
      return {'success': false, 'message': 'Credentials exist'};
    }
    return {'success': true, 'data': user.toJson()};
  }
}