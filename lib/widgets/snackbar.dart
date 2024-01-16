import 'package:flutter/material.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';

class SnackBarError extends StatelessWidget {
  final String text;
  final Color? colorBox;
  const SnackBarError({super.key, required this.text,this.colorBox});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width(context) * 0.1,
        // vertical: 20,
      ),
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: width(context) * 0.03),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorBox??Colors.white.withOpacity(1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: CustomTextWidget(
            color: Colors.black,
            text: text,
            textAlign: TextAlign.center,
            fontSize: width(context) * 0.04,
          )),
    );
  }
}
