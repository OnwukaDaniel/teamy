import 'package:teamy/imports.dart';

mixin ThemeHelper {
  static const double titleLarge = 24;
  static const double titleMedium = 20;
  static const double bodyLarge = 18;
  static const double bodyMedium = 16;
  static const double bodySmall = 14;
  static const double labelLarge = 12;
  static const double labelMedium = 10;

  TextStyle get tl => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .titleLarge!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get tm => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .titleMedium!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get bl => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .bodyLarge!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get bm => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .bodyMedium!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get bs => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .bodySmall!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get ll => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .labelLarge!
      .copyWith(fontFamily: 'InterRegular');

  TextStyle get lm => Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .labelMedium!
      .copyWith(fontFamily: 'InterRegular');

  Color get bgColor =>
      Theme.of(navigatorKey.currentState!.context).scaffoldBackgroundColor;

  Color get appBarColor =>
      Theme.of(navigatorKey.currentState!.context).appBarTheme.backgroundColor!;

  Color get btnColor =>
      Theme.of(
        navigatorKey.currentState!.context,
      ).buttonTheme.colorScheme!.primary;

  Color get cardColor => Theme.of(navigatorKey.currentState!.context).cardColor;

  Color get cardTheme =>
      Theme.of(navigatorKey.currentState!.context).cardTheme.color!;

  Color get hintColor => Theme.of(navigatorKey.currentState!.context).hintColor;

  Color get dividerColor =>
      Theme.of(navigatorKey.currentState!.context).dividerColor;

  Color get canvasColor =>
      Theme.of(navigatorKey.currentState!.context).canvasColor;

  Color get iconColor =>
      Theme.of(
        navigatorKey.currentState!.context,
      ).buttonTheme.colorScheme!.primary;

  bool get isDark => themeData.value == AppTheme.darkTheme;

// bool get isDark =>
//     Theme.of(navigatorKey.currentState!.context).brightness ==
//     Brightness.dark;
}
