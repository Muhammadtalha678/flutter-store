import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkProvider extends ChangeNotifier {
  bool _netIsLoading = false;
  bool get netIsLoading => _netIsLoading;
  Future<bool> network() async {
    try {
      _netIsLoading = true;
      notifyListeners();
      final response = await http
          .get(Uri.parse("http://www.google.com"))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
      // notifyListeners();
    } on TimeoutException catch (e) {
      print(e);
      return false;
    } on SocketException catch (e) {
      return false;
    } catch (e) {
      return false;
    } finally {
      _netIsLoading = false;
      notifyListeners();
    }
  }
}
