import 'dart:developer' as l;

extension StringExtension on String {
  String get capitalize => isEmpty? this: this[0].toUpperCase() + substring(1);
  void get log => l.log('APP LOG ************** $this');
}