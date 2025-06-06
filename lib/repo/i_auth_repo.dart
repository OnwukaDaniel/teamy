import '../imports.dart';

abstract class IAuthRepo {
  Future<NetworkData> signIn(String email, String password);
  Future<NetworkData> signUp(String email, String password, String name);
  Future<UserData?> getLocalUser();
}
