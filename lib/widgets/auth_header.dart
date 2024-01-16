import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';

class AuthHeader extends StatelessWidget {
  final String mainHeading;
  final String subHeading;
  final Function()? onTap;
  const AuthHeader({
    required this.mainHeading,
    required this.subHeading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width(context) * 0.05,
          vertical: height(context) * 0.03),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.green,
            Colors.green.shade400,
            Colors.green.shade200,
          ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: height(context) * 0.03,
          ),
          CustomTextWidget(
            textAlign: TextAlign.start,
            text: mainHeading,
            color: Colors.white,
            fontSize: width(context) * 0.1,
            //  fontSize: 34,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: height(context) * 0.01,
          ),
          CustomTextWidget(
            text: subHeading,
            color: Colors.black,
            fontSize: width(context) * 0.035,
            //  fontSize: 14,
            letterSpacing: 0.5,
          )
        ],
      ),
    );
  }
}
