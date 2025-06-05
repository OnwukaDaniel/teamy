import 'package:teamy/imports.dart';

class SignInViewmodel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _visiblePassword = false;
  bool _visibleConfirmPassword = false;
  final signInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  bool get visibleConfirmPassword => _visibleConfirmPassword;

  setVisibleConfirmPassword(bool value) {
    _visibleConfirmPassword = value;
    notifyListeners();
  }

  logIn(BuildContext context) async {
    if (!signInFormKey.currentState!.validate()) return;
    setBusy(true);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final res = await AuthRepo.signIn(email, password);
    setBusy(false);
    switch (res.status) {
      case true:
        if (res.data == null) {
          AppMessage.msg(res.message);
        } else if (context.mounted) {
          completeAuth(res, context, create: false);
        }
        break;
      case false:
        AppMessage.msg(res.message);
        break;
    }
  }

  signUp(BuildContext context) async {
    if (!signUpFormKey.currentState!.validate()) return;
    setBusy(true);
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final email = emailController.text.trim();
    final res = await AuthRepo.signUp(email, password, name);

    setBusy(false);
    switch (res.status) {
      case true:
        if (res.data == null) {
          AppMessage.msg(res.message);
        } else if (context.mounted) {
          completeAuth(res, context, create: true);
        }
        break;
      case false:
        AppMessage.msg(res.message);
        break;
    }
  }

  goToSignUp(BuildContext context) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => SignUp()));
  }

  goToSignIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => SignIn()),
    );
  }

  completeAuth(NetworkData res, BuildContext context, {required bool create}) async {
    final user = res.data as UserData;
    if (create) {
      final jsonString = await LocalStorage.getStringList(Preferences.usersListJson);
      jsonString.add(jsonEncode(user.toJson()));
      LocalStorage.setStringList(Preferences.usersListJson, jsonString);
    }
    LocalStorage.setString(Preferences.usersJson, jsonEncode(user));
    AppMessage.msg(res.message, color: Colors.green, textColor: Colors.white);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (_) => Home()),
      (_) => false,
    );
  }
}
