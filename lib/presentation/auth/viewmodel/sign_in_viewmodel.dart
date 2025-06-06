import 'package:teamy/imports.dart';

class SignInViewmodel extends BaseViewModel {
  final IAuthRepo authRepo = AuthRepo();
  final nameController = TextEditingController();
  final rePasswordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    final res = await authRepo.signIn(email, password);
    setBusy(false);
    if (res == null) {
      AppMessage.msg('Unable to sign in');
    } else if (context.mounted) {
      LocalStorage.setString(Preferences.usersJson, jsonEncode(res));
      AppMessage.msg('Success', color: Colors.green, textColor: Colors.white);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => Home()),
              (_) => false,
        );
      }
    }
  }

  signUp(BuildContext context) async {
    if (!signUpFormKey.currentState!.validate()) return;
    setBusy(true);
    final name = nameController.text.trim();
    final password = passwordController.text.trim();
    final email = emailController.text.trim();
    final res = await authRepo.signUp(email, password, name);

    setBusy(false);
    if (res == null) {
      AppMessage.msg('Unable to sign up');
    } else if (context.mounted) {
      LocalStorage.setString(Preferences.usersJson, jsonEncode(res));
      AppMessage.msg('Success', color: Colors.green, textColor: Colors.white);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => Home()),
          (_) => false,
        );
      }
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

  completeAuth(
    NetworkData res,
    BuildContext context, {
    required bool create,
  }) async {
    final user = res.data as UserData;
    if (create) {
      final jsonString = await LocalStorage.getStringList(
        Preferences.usersListJson,
      );
      jsonString.add(jsonEncode(user.toJson()));
      LocalStorage.setStringList(Preferences.usersListJson, jsonString);
    }
    LocalStorage.setString(Preferences.usersJson, jsonEncode(user));
    AppMessage.msg(res.message, color: Colors.green, textColor: Colors.white);
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => Home()),
        (_) => false,
      );
    }
  }
}
