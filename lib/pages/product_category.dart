import 'package:flutter/material.dart';
import 'package:newstore/constants/constants.dart';
import 'package:newstore/provider/allData_provider.dart';
import 'package:newstore/widgets/appBar_widget.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final CatId = ModalRoute.of(context)!.settings.arguments;
    // print(produId);
    List categoryProduct = [];
    for (var element in context.read<AllDataProvider>().product_model) {
      final id = element.categoryId;
      final query = CatId;
      print(id);
      print("");
      print(query);
      if (id == query) {
        categoryProduct.add(element);
      }
    }
    return Scaffold(
      backgroundColor: myDefaultColor,
      // appBar: PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: MyAppBar(titleText: "titleText", titlefontSize: titlefontSize),),
    );
  }
}
