import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/constants.dart';
import 'package:newstore/provider/secure_storage_provider.dart';
import 'package:newstore/secure_storage/secure_storage.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier {
  //check if isLoading mean data is catch or not
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _credentialError = "";
  String get credentialError => _credentialError;

  // store the name error
  String _nameError = "";
  String get nameError => _nameError;

  // store the email error
  String _emailError = "";
  String get emailError => _emailError;

  // store the password error
  String _passwordError = "";
  String get passwordError => _passwordError;

  // Register Successfull
  bool _isRegister = false;
  bool get isRegister => _isRegister;

  // network error
  bool _networkError = false;
  bool get networkError => _networkError;
  Future<int?> register(BuildContext context, String name, String email,
      String password, String confirmPassword) async {
    Map registerData = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http
          .post(
            Uri.parse('$url/register'),
            headers: {
              'Authorization': 'Bearer $authtoken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(registerData),
          )
          .timeout(Duration(seconds: 10));
      Map responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (_networkError == true) {
          _networkError = false;
        }
        await SecureStorage().saveData('token', responseData['token']);
        context.read<SecureStorageProvider>().security();
        return 200;
      } else if (response.statusCode == 422) {
        if (_networkError == true) {
          _networkError = false;
        }
        Map errorData = responseData['errors'];
        if (errorData.containsKey('name')) {
          _nameError = errorData['name'][0];
          _removeErrorAfterDelay(() {
            return _nameError = "";
          });
        }
        if (errorData.containsKey('email')) {
          _emailError = errorData['email'][0];
          _removeErrorAfterDelay(() {
            return _emailError = "";
          });
        }
        if (errorData.containsKey('password')) {
          _passwordError = errorData['password'][0];
          _removeErrorAfterDelay(() {
            return _passwordError = "";
          });
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      _networkError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _removeErrorAfterDelay(Function callback) async {
    Future.delayed(const Duration(seconds: 10), () {
      callback();
      notifyListeners();
    });
  }

  void registerMobileUser(
      String text, String text2, String text3, String text4) {}
}
