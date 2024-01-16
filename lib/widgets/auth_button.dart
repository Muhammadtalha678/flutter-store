import 'package:flutter/material.dart';
import 'package:newstore/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double? fontSize;
  final double? padding;
  // final Function() onPressed;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: CustomTextWidget(
            text: buttonText,
            fontSize: fontSize ?? 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
