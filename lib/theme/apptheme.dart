import 'package:teamy/imports.dart';
import 'package:teamy/theme/text_utils.dart';

class AppTheme {
  static const double titleLarge = 24;
  static const double titleMedium = 20;
  static const double titleSmall = 18;
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;
  static const double labelLarge = 10;
  static const double labelMedium = 8;

  static String fontFamily = 'Monterrat';

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      titleLarge: TextStyle(
          color: textColor, fontSize: titleLarge, fontFamily: fontFamily),
      titleMedium: TextStyle(
          color: textColor, fontSize: titleMedium, fontFamily: fontFamily),
      titleSmall: TextStyle(
          color: textColor, fontSize: titleMedium, fontFamily: fontFamily),
      bodyLarge: TextStyle(
          color: textColor, fontSize: bodyLarge, fontFamily: fontFamily),
      bodyMedium: TextStyle(
          color: textColor, fontSize: bodyMedium, fontFamily: fontFamily),
      bodySmall: TextStyle(
          color: textColor, fontSize: bodySmall, fontFamily: fontFamily),
      labelLarge: TextStyle(
          color: textColor, fontSize: labelLarge, fontFamily: fontFamily),
      labelMedium: TextStyle(
          color: textColor, fontSize: labelMedium, fontFamily: fontFamily),
    );
  }

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF8F8F8),
    hintColor: Colors.grey,
    primaryColor: AppColor.appColor,
    canvasColor: Colors.white,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    dividerColor: const Color(0xfff0f0f0),
    cardColor: const Color(0xFFE7E7E7),
    fontFamily: fontFamily,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      focusColor: const Color.fromARGB(255, 34, 255, 0),
      buttonColor: Colors.black87,
      disabledColor: const Color.fromARGB(255, 197, 95, 95).withOpacity(0.1),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.grey,
        onPrimary: Colors.white,
        secondary: AppColor.appColor,
        onSecondary: Colors.white,
        error: AppColor.appColor,
        onError: Colors.white,
        surface: AppColor.appColor,
        onSurface: Colors.white,
      ),
    ),
    cardTheme: const CardTheme(color: Color(0xffffffff)),
    textTheme: _buildTextTheme(Colors.black),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF101010),
    hintColor: Colors.grey,
    primaryColor: AppColor.appColor,
    canvasColor: const Color(0xff444343),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    fontFamily: fontFamily,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey.withOpacity(0.8),
      disabledColor: Colors.grey.withOpacity(0.1),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.white,
        secondary: AppColor.appColor,
        onSecondary: Colors.white,
        error: Colors.grey.withOpacity(0.1),
        onError: Colors.white,
        surface: Colors.grey.withOpacity(0.1),
        onSurface: Colors.grey,
      ),
    ),
    dividerColor: const Color(0xff2d2d2d),
    cardColor: Colors.black38,
    cardTheme: const CardTheme(color: Color(0xff1f1f1f)),
    textTheme: _buildTextTheme(Colors.white),
  );

  // Helpers //

  // Background Color
  static Color bgColor() {
    return TextUtils.themeData.scaffoldBackgroundColor;
  }
  static Color bgColorOf(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  // On Primary Color
  static Color onPrimary() {
    return TextUtils.themeData.colorScheme.onPrimary;
  }
  static Color onPrimaryOf(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  // Hint Color
  static Color hintColor() {
    return TextUtils.themeData.hintColor;
  }
  static Color hintColorOf(BuildContext context) {
    return Theme.of(context).hintColor;
  }

  // Card Color
  static Color cardColor() {
    return TextUtils.themeData.cardColor;
  }
  static Color cardColorOf(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  // Card Theme Color
  static Color? cardTheme() {
    return TextUtils.themeData.cardTheme.color;
  }
  static Color? cardThemeOf(BuildContext context) {
    return Theme.of(context).cardTheme.color;
  }
}
