import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/constants.dart';
import 'package:newstore/models/banner_model.dart';

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

  Future<void> getImages() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(
        Uri.parse('$url/images'),
        headers: {
          'Authorization': token,
        },
      );
      final jsonDec = jsonDecode(response.body);
      List<dynamic> data = jsonDec['images'];

      // print(data.map((e) {
      //   Banners.fromJson(e);
      // }));

      _banner = data.map((e) => Banners.fromJson(e)).toList();
      // print(_banner[0].sliderImages);
      _sliderImages = jsonDecode(_banner[0].sliderImages);
      // print(d);
      // notifyListeners();
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
