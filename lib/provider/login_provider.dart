import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/constants.dart';
import 'package:newstore/provider/secure_storage_provider.dart';
import 'package:newstore/secure_storage/secure_storage.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  //is login user
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  //if response take time then loader comes when false
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //store the credentil error
  final String _credentialError = "";
  String get credentialError => _credentialError;

//store the email error
  String _emailError = "";
  String get emailError => _emailError;

//store the password error
  String _passwordError = "";
  String get passwordError => _passwordError;

  //network error
  bool _networkError = false;
  bool get networkError => _networkError;

  Future<void> loginMobileUser(
      BuildContext context, String email, String password) async {
    //Store Data in Map
    Map loginData = {
      'email': email,
      'password': password,
    };
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http
          .post(
            Uri.parse("$url/login"),
            headers: {
              'Authorization': 'Bearer $authtoken',
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: jsonEncode(loginData),
          )
          .timeout(Duration(seconds: 10));
      // print(response.statusCode);
      Map responseDecode = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await SecureStorage().saveData('token', responseDecode['token']);
        // ignore: use_build_context_synchronously
        context.read<SecureStorageProvider>().security();
        _isLogin = true;
        _logoutUser = false;
        if (_networkError == true) {
          _networkError = false;
        }
      } else if (response.statusCode == 423) {
        _emailError = responseDecode['email'];
        _removeErrorAfterDelay(() {
          return _emailError = "";
        });
        if (_networkError == true) {
          _networkError = false;
        }
      } else if (response.statusCode == 422) {
        Map error = responseDecode['errors'];
        if (error.containsKey('email')) {
          _emailError = error['email'][0];
          _removeErrorAfterDelay(() {
            return _emailError = "";
          });
        }
        if (error.containsKey('password')) {
          _passwordError = error['password'][0];
          _removeErrorAfterDelay(() {
            return _passwordError = "";
          });
        }
        if (_networkError == true) {
          _networkError = false;
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      if (e is SocketException) {
        _networkError = true;
        // notifyListeners();
        print(e);
      } else if (e is TimeoutException) {
        print(e);
        _networkError = true;
      } else {
        _networkError = true;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    // print(_networkError);
    //Send the data and store the response in response variable
  }

  bool _logoutUser = false;
  bool get logoutUser => _logoutUser;

  bool _invalidtoken = false;
  bool get invalidtoken => _invalidtoken;

  bool _logoutNetwork = false;
  bool get logoutNetwork => _logoutNetwork;
  Future<void> logout(BuildContext context) async {
    try {
      final logoutResponse = await http.delete(
        Uri.parse('$url/logout'),
        headers: {
          'Authorization':
              'Bearer ${context.read<SecureStorageProvider>().token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(
        Duration(seconds: 10),
      );
      print(logoutResponse.statusCode);
      if (logoutResponse.statusCode == 200) {
        if (_logoutNetwork == true) {
          // print(_logoutNetwork);
          _logoutNetwork = false;
          // print(_logoutNetwork);
        }
        if (_invalidtoken == true) {
          _invalidtoken = false;
        }
        context.read<SecureStorageProvider>().LogoutSecurity();
        _logoutUser = true;
        _isLogin = false;
      }
      if (logoutResponse.statusCode == 401) {
        if (_logoutNetwork == true) {
          _logoutNetwork = false;
        }
        _invalidtoken = true;
      } else {
        if (_invalidtoken == true) {
          _invalidtoken = false;
          // print(_logoutNetwork);
        }
        // print("object");
        if (!_logoutUser) {
          throw Exception();
        }
      }
    } on TimeoutException catch (e) {
      // print(e);
      if (_invalidtoken == true) {
        _invalidtoken = false;
        // print(_logoutNetwork);
      }
      _logoutNetwork = true;
    } catch (e) {
      // print(e);
      if (_invalidtoken == true) {
        _invalidtoken = false;
        // print(_logoutNetwork);
      }
      _logoutNetwork = true;
    } finally {
      notifyListeners();
    }
  }

  void _removeErrorAfterDelay(Function callback) async {
    Future.delayed(const Duration(seconds: 10), () {
      callback();
      notifyListeners();
    });
  }
}
