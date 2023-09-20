import 'package:flutter/material.dart';

class Check_password with ChangeNotifier {
  var password1 = '';

  // String get password => password1;

  void check(String password1) {
    this.password1 = password1;
    notifyListeners();
  }
}
