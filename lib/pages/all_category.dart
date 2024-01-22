import 'package:flutter/material.dart';
import 'package:newstore/constants/constants.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/provider/allData_provider.dart';
import 'package:newstore/widgets/appBar_widget.dart';
import 'package:newstore/widgets/grid_view_widget.dart';
import 'package:newstore/widgets/two_value_card.dart';
import 'package:provider/provider.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          titleText: "Categories",
          titlefontSize: width(context) * 0.05,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: width(context) * 0.05,
            ),
          ),
          actionwidget: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.03,
                vertical: width(context) * 0.006),
            child: GestureDetector(
              child: Icon(
                Icons.search,
                size: width(context) * 0.05,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => MobileSearchPage(),));
                // route.navigateTo(Navigate.search, context, NavigationData());
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context) * 0.03,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height(context) * 0.025,
                ),
                Consumer<AllDataProvider>(
                  builder: (context, value, child) {
                    return GridViewBuilder(
                      aspectRatio: 1,
                      itemCount: 7,
                      crossAxisCount: 3,
                      itemBuilder: (p0, p1) {
                        return Padding(
                          padding: EdgeInsets.all(width(context) * 0.01),
                          child: TwoValueCard(
                              onTap: () {
                                Future.delayed(
                                  Duration(milliseconds: 200),
                                  () {
                                    // print(value.category_model[p1].name);
                                    Navigator.pushNamed(
                                        context, '/productByCategory',
                                        arguments: value.category_model[p1].id);
                                  },
                                );
                              },
                              text: value.category_model[p1].name,
                              networkImage: value.category_model[p1].images),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
