import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newstore/constants/media_query.dart';
import 'package:newstore/widgets/text_widget.dart';
import 'package:newstore/widgets/textfield_widget.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final int? errorMaxLines;

  final String? errorText;
  final Function()? onEditingComplete;
  final TextInputType? KeyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const AuthTextField(
      {required this.label,
      required this.icon,
      this.suffixIcon,
      this.obscureText,
      this.controller,
      this.onChanged,
      this.inputFormatters,
      this.errorText,
      this.errorMaxLines,
      this.onEditingComplete,
      this.focusNode,
      this.KeyboardType,
      this.textInputAction,
      });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: textInputAction,
      keyboardType: KeyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      label: CustomTextWidget(
          text: label,
          color: Colors.black,
          fontSize: width(context) * 0.04),

      // lableText: "User Name",
      prefixIcon: Icon(
        icon,
        size: width(context) * 0.04,
      ),
      onChanged: onChanged,
      errorText: errorText,
      suffixIcon: suffixIcon,
      textSize: width(context) * 0.04,
      inputFormatters: inputFormatters,
      // borderSide: BorderSide.none,
      controller: controller,
      enable: true,
      obscureText: obscureText,
      filled: false,
      borderRadius: 10,
      fillColor: Colors.transparent,
      borderSideColor: Colors.green,
      textColor: Colors.black,
      autofocus: false,
      cursorColor: Colors.blueGrey,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      errorMaxLines: errorMaxLines,
      floatingLabelStyle:
          TextStyle(fontSize: width(context) * 0.04),
    );
  }
}
