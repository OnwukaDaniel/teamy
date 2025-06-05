import 'package:teamy/imports.dart';

mixin StaticWidgets {
  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.withAlpha(40)),
    );
  }
}
