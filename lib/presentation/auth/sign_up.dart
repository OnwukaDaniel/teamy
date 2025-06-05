import 'package:teamy/imports.dart';

class SignUp extends StatelessWidget with ThemeHelper, StaticWidgets {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewmodel(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: bgColor,
          body: Form(
            key: model.signUpFormKey,
            child: ListView(
              children: [
                (kToolbarHeight * .5).h,
                Image.asset('assets/sign_up_image.png'),
                12.h,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Sign Up',
                    style: tl.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                input(
                  model,
                  hint: 'Name',
                  keyboardType: TextInputType.name,
                  controller: model.nameController,
                  validator: ValidatorService.validateName,
                ),
                input(
                  model,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: model.emailController,
                  validator: ValidatorService.validateEmail,
                ),
                input(
                  model,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: model.passwordController,
                  obscureText: model.visibleConfirmPassword,
                  validator: ValidatorService.validatePassword,
                ),
                input(
                  model,
                  hint: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: model.rePasswordController,
                  obscureText: model.visiblePassword,
                  validator:
                      (v) => ValidatorService.validateConfirmPassword(
                        v,
                        model.passwordController.text.trim(),
                      ),
                ),
                8.h,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () => model.signUp(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColor.appColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child:
                        model.isBusy
                            ? CircularProgressIndicator(color: Colors.white)
                            : Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Sign In',
                                style: bl.copyWith(color: Colors.white),
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () => model.goToSignIn(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Don't have an account Sign In",
                style: bm.copyWith(decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget input(
    SignInViewmodel model, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    String? hint,
    String? Function(String?)? validator,
  }) {
    Widget eyeIcon() {
      return IconButton(
        onPressed:
            () =>
                (hint ?? '').contains('confirm')
                    ? model.setVisiblePassword(!obscureText)
                    : model.setVisibleConfirmPassword(!obscureText),
        icon: Icon(
          obscureText
              ? Icons.remove_red_eye_outlined
              : Icons.visibility_off_outlined,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 12, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(hint ?? '', style: bm.copyWith(color: Colors.grey)),
          8.h,
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              focusedBorder: border(),
              filled: true,
              hintText: hint,
              fillColor: Colors.grey.withAlpha(40),
              border: border(),
              enabledBorder: border(),
              suffixIcon:
                  keyboardType == TextInputType.visiblePassword
                      ? eyeIcon()
                      : null,
            ),
          ),
        ],
      ),
    );
  }
}
