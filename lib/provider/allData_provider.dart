import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newstore/constants/constants.dart';
import 'package:newstore/models/category_model.dart';
import 'package:newstore/models/product_model.dart';

class AllDataProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //for Categories
  List<CategoryModel> _category_model = [];
  List<CategoryModel> get category_model => _category_model;
  //for Products
  List<ProductModel> _product_model = [];
  List<ProductModel> get product_model => _product_model;

  Future<bool> allData() async {
    if (_category_model.isEmpty || _product_model.isEmpty) {
      try {
        _isLoading = true;
        notifyListeners();
        //for Categories
        final categoryResponse =
            await http.get(Uri.parse('$url/categories'), headers: {
          'Authorization': '$token',
          // 'applcation-type' : 'j'
        }).timeout(Duration(seconds: 10));

        //for Products
        final productResponse = await http.get(
          Uri.parse('$url/products'),
          headers: {'Authorization': '$token'},
        ).timeout(
          Duration(seconds: 10),
        );

        if (categoryResponse.statusCode == 200 &&
            productResponse.statusCode == 200) {
          // for Categories
          Map _categoryData = jsonDecode(categoryResponse.body);
          List _categories = _categoryData['categories'];
          _category_model =
              _categories.map((e) => CategoryModel.fromJson(e)).toList();
          // for (var element in category_model) {
          //   print(NetworkImage(
          //     element.images,
          //   ));
          // }

          // for Products
          Map _productData = jsonDecode(productResponse.body);
          List _products = _productData['products'];
          _product_model =
              _products.map((e) => ProductModel.fromJson(e)).toList();
          // print(_products);
          return true;
        } else {
          throw Exception();
        }
      } catch (e) {
        // print(e);
        return false;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      return true;
    }
  }
}
