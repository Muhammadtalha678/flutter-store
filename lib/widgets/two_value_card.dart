import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';

class TwoValueCard extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String networkImage;
  const TwoValueCard({
    required this.text,
    required this.networkImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        splashColor: Colors.green.shade200,
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 0.5.h,),
            Padding(
              padding: EdgeInsets.only(
                  top: height(context) * 0.01,
                  left: width(context) * 0.01,
                  right: width(context) * 0.01),
              child: Align(
                alignment: Alignment.center,
                child: CustomTextWidget(
                  textAlign: TextAlign.center,
                  text: text,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width(context) * 0.032,
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.005,
            ),
            Expanded(
                // flex: 3,
                child:
                    // Image(
                    //   image: NetworkImage(networkImage??""),
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    //   filterQuality: FilterQuality.high,
                    // ),
                    Padding(
              padding: EdgeInsets.only(bottom: height(context) * 0.01),
              child: Image.network(
                networkImage,
                width: double.infinity,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
