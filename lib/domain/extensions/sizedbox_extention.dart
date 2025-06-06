import 'package:teamy/imports.dart';

extension IntegerExtension on int {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension DoubleExtension on double {
  SizedBox get h => SizedBox(height: this);
  SizedBox get w => SizedBox(width: this);
}