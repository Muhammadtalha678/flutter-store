import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.borderRadius,
    this.borderSide,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderSideColor,
    this.hintText,
    this.hintFontsize,
    this.hintColor,
    this.contentPadding,
    this.textSize,
    this.textColor,
    this.textFontWeight,
    this.obscureText,
    this.autofocus,
    this.enable,
    this.cursorColor,
    this.cursorHeight,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.label,
    this.labelStyle,
    this.lableText,
    this.filled,
    this.floatingLabelBehavior,
    this.floatingLabelStyle,
    this.inputFormatters,
    this.errorText,
    this.errorMaxLines,
    this.keyboardType,
    this.textInputAction,
  });

  final double? borderRadius;
  final BorderSide? borderSide;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderSideColor;
  final String? hintText;
  final double? hintFontsize;
  final Color? hintColor;
  final double? contentPadding;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final bool? obscureText;
  final bool? autofocus;
  final bool? enable;
  final Color? cursorColor;
  final double? cursorHeight;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Widget? label;
  final TextStyle? labelStyle;
  final String? lableText;
  final bool? filled;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? floatingLabelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final int? errorMaxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus ?? true,
      enabled: enable,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: borderSide ?? BorderSide(),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: filled ?? true,
          fillColor: fillColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            borderSide: BorderSide(color: borderSideColor ?? Colors.black),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.nunito(
            fontSize: hintFontsize,
            color: hintColor,
          ),
          contentPadding: EdgeInsets.all(contentPadding ?? 0),
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.never,
          floatingLabelStyle: floatingLabelStyle,
          label: label,
          labelStyle: labelStyle,
          labelText: lableText,
          prefixIconColor: Colors.black,
          errorText: errorText,
          errorMaxLines: errorMaxLines),
      style: GoogleFonts.nunito(
        fontSize: textSize,
        color: textColor,
        fontWeight: textFontWeight,
      ),
      textAlign: TextAlign.start,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: inputFormatters,
    );
  }
}
