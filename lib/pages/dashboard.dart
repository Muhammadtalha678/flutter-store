import 'package:flutter/material.dart';
import 'package:newstore/constants/constants.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/appBar_widget.dart';
import 'package:newstore/widgets/carousel_slider.dart';
import 'package:newstore/widgets/textfield_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          titleText: "Jalal Store",
          action1Text: "Delivery",
          action2Text: "9 Nov 2023",
          titlefontSize: MediaQuery.of(context).size.width * 0.05,
          action1size: MediaQuery.of(context).size.width * 0.025,
          action2size: MediaQuery.of(context).size.width * 0.026,
        ),
      ),
      backgroundColor: myDefaultColor,
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
                GestureDetector(
                  onTap: () {},
                  child: CustomTextField(
                    prefixIcon: Icon(
                      Icons.search,
                      size: width(context) * 0.05,
                      color: Colors.black54,
                    ),
                    borderRadius: 30,
                    hintText: "Search for Products",
                    hintColor: Colors.black54,
                    hintFontsize: MediaQuery.of(context).size.width * 0.04,
                    borderSide: BorderSide.none,
                    enable: false,
                    fillColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.025,
                ),
                Carousel()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
