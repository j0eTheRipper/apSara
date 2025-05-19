import 'package:flutter/material.dart';

class StudentInfoModel extends ChangeNotifier {
  late final String _intakeCode;
  late final String _grouping;

  String get intakeCode => _intakeCode;
  String get grouping => _grouping;

  set intakeCode(String value) {
    RegExp intakePattern = RegExp(r"AP(U|D)[0-9]F[0-9]{4}[A-Z]*(\([A-Z]+\))?");
    if (intakePattern.hasMatch(value)) {
      _intakeCode = value;
      notifyListeners();
    }
  }

  set grouping(String value) {
    RegExp groupNumberPattern = RegExp(r"G[1-9]");
    if (groupNumberPattern.hasMatch(value)) {
      _grouping = value;
      notifyListeners();
    }
  }
}