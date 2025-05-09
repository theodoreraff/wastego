import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName;
  int _points;
  String _userId;

  UserProvider(this._userName, this._points, this._userId);

  String get userName => _userName;
  int get points => _points;
  String get userId => _userId;

  void updateUser(String userName, int points, String userId) {
    _userName = userName;
    _points = points;
    _userId = userId;
    notifyListeners();
  }
}
