import 'package:flutter/material.dart';
import 'package:newstore/secure_storage/secure_storage.dart';

class SecureStorageProvider extends ChangeNotifier {
  String _token = "";
  String get token => _token;
  void security() async {
    _token = await SecureStorage().getData('token');
    notifyListeners();
  }

  void LogoutSecurity() async {
    await SecureStorage().deleteAll();
    _token = "";
    notifyListeners();
  }
}
