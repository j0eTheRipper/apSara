import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String tpNumber, password, intake, group;

  User({
    required this.tpNumber,
    required this.password,
    required this.intake,
    required this.group,
  });
}

class UserDetailsModel extends ChangeNotifier {
  String _tpNumber = "";
  String password = "";
  late bool _isLoggedIn;

  UserDetailsModel(this._tpNumber, this.password) {
    _setIsLoggedIn();
  }

  String get tpNumber => _tpNumber;
  set tpNumber(String value) {
    value = value.trim();
    RegExp regExp = RegExp(r"^TP\d{6}$");
    if (regExp.hasMatch(value)) {
      _tpNumber = value;
    }
  }

  Future<void> _setIsLoggedIn() async {
    final localData = SharedPreferencesAsync();
    _isLoggedIn = await localData.getBool('isLoggedIn') ?? false;
  }
}
