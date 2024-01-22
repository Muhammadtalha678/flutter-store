import 'package:flutter/material.dart';
import 'package:newstore/widgets/text_widget.dart';

class Headings extends StatelessWidget {
  final String text;
  final double fontSize;
  final Widget? subwidget;
  final Color? color;
  final FontStyle? fontStyle;
  const Headings({
    required this.text,
    required this.fontSize,
    this.subwidget,
    this.color,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          fontStyle: fontStyle,
          text: text,
          fontSize: fontSize,
          color: color ?? Colors.black,
          fontWeight: FontWeight.w900,
        ),
        subwidget ?? Container()
      ],
    );
  }
}
