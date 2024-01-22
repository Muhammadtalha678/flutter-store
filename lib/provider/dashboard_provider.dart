import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/constants.dart';
import 'package:newstore/models/banner_model.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/snackbar.dart';
import 'package:newstore/widgets/snackbar.dart';

class DashboardProvider extends ChangeNotifier {
  int currentDot = 0;
  void carouselDot(int currentIndex) {
    currentDot = currentIndex;
    notifyListeners();
  }

  List<Banners> _banner = [];
  List<Banners> get banner => _banner;

  List _sliderImages = [];
  List get sliderImages => _sliderImages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _networkError = false;
  bool get networkError => _networkError;

  Future<void> getImages(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse('$url/images'),
        headers: {
          'Authorization': token,
        },
      ).timeout(Duration(seconds: 20));
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonDec = jsonDecode(response.body);
        List<dynamic> data = jsonDec['images'];
        _banner = data.map((e) => Banners.fromJson(e)).toList();
        _sliderImages = jsonDecode(_banner[0].sliderImages);
        if (_networkError == true) {
          _networkError = false;
        }
      } else {
        if (!_networkError) {
          throw Exception();
        }
        // notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarError(
            text: "Network Error",
          ),
        ),
      );
      _networkError = true;
      // notifyListeners();
      // print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
