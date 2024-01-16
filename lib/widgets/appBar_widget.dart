import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar(
      {required this.titleText,
      required this.titlefontSize,
      this.action1Text,
      this.action1size,
      this.action2Text,
      this.action2size,
      this.actionwidget,
      this.bottomLeft,
      this.bottomRight,
      this.leading,
      this.color,
      this.centerTitle});
  final String titleText;
  final double titlefontSize;
  final String? action1Text;
  final double? action1size;
  final String? action2Text;
  final double? action2size;
  final double? bottomRight;
  final double? bottomLeft;
  final Widget? actionwidget;
  final Widget? leading;
  final Color? color;
  final bool? centerTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(bottomLeft ?? 0),
        bottomRight: Radius.circular(bottomRight ?? 0),
      )),
      systemOverlayStyle: const SystemUiOverlayStyle(
          // statusBarColor: Color.fromARGB(235, 165, 214, 167),
          statusBarColor: Color.fromARGB(235, 165, 214, 167),
          statusBarIconBrightness: Brightness.light),
      elevation: 0,
      backgroundColor: color ?? Colors.green.shade200,
      title: Row(
        children: [
          leading ?? Container(),
          SizedBox(width: width(context) * 0.01),
          CustomTextWidget(
            text: titleText,
            fontSize: titlefontSize,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
      // titleSpacing: 0,
      actions: [
        actionwidget ??
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.03,
                  vertical: width(context) * 0.006),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: action1Text ?? "",
                    fontSize: action1size,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomTextWidget(
                    text: action2Text ?? "",
                    fontSize: action2size,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
      ],
    );
  }
}
