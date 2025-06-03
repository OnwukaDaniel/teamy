import 'package:teamy/imports.dart';

class TextUtils {
  static ThemeData get themeData => navigatorKey.currentContext == null
      ? ThemeData.light()
      : Theme.of(navigatorKey.currentContext!);

  static TextStyle titleLarge() {
    return themeData.textTheme.titleLarge!;
  }

  static TextStyle titleLargeOf(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle titleMedium() => themeData.textTheme.titleMedium!;

  static TextStyle titleMediumOf(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle titleSmall() => themeData.textTheme.titleSmall!;

  static TextStyle titleSmallOf(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!;

  static TextStyle bodyLarge() => themeData.textTheme.bodyLarge!;

  static TextStyle bodyLargeOf(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!;

  static TextStyle bodyMedium() => themeData.textTheme.bodyMedium!;

  static TextStyle bodyMediumOf(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle bodySmall() => themeData.textTheme.bodySmall!;

  static TextStyle bodySmallOf(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle labelLarge() => themeData.textTheme.labelLarge!;

  static TextStyle labelLargeOf(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!;

  static TextStyle labelMedium() => themeData.textTheme.labelMedium!;

  static TextStyle labelMediumOf(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!;
}
