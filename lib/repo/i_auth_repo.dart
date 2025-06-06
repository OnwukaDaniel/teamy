import '../imports.dart';

abstract class IAuthRepo {
  Future<UserData?> signIn(String email, String password);
  Future<UserData?> signUp(String email, String password, String name);
  Future<UserData?> getLocalUser();
}