

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final Paint? background;
   final Color? backgroundColor;
   final Color? color;
   final TextDecoration? decoration;
   final Color? decorationColor;
   final TextDecorationStyle? decorationStyle;
   final double? decorationThickness;
   final List<FontFeature>? fontFeatures;
   final double? fontSize;
   final FontStyle? fontStyle;
   final FontWeight? fontWeight;
   final Paint? foreground;
   final double? height;
   final double? letterSpacing;
   final List<Shadow>? shadows;
   final TextBaseline? textBaseline;
   final TextStyle? textStyle;
   final double? wordSpacing ;
  const CustomTextWidget({
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    //  GoogleFonts
     this.background,
     this.backgroundColor,
     this.color,
     this.decoration,
     this.decorationColor,
     this.decorationStyle,
     this.decorationThickness,
     this.fontFeatures,
     this.fontSize,
     this.fontStyle,
     this.fontWeight,
     this.foreground,
     this.height,
     this.letterSpacing,
     this.shadows,
     this.textBaseline,
     this.textStyle,
     this.wordSpacing,
     }
   );

  @override
  Widget build(BuildContext context) {
    return Text(
       text,
       strutStyle: strutStyle,
       textAlign: textAlign,
       textDirection: textDirection,
       locale: locale,
       softWrap: softWrap,
       overflow: overflow,
       textScaleFactor: textScaleFactor,
       maxLines: maxLines,
       semanticsLabel: semanticsLabel,
       textWidthBasis: textWidthBasis,
       textHeightBehavior: textHeightBehavior,
       selectionColor: selectionColor,
       style: GoogleFonts.aBeeZee(
            background:background,
            backgroundColor:backgroundColor,
            color:color,
            decoration:decoration,
            decorationColor:decorationColor,
            decorationStyle:decorationStyle,
            decorationThickness:decorationThickness,
            fontFeatures:fontFeatures,
            fontSize:fontSize,
            fontStyle:fontStyle,
            fontWeight:fontWeight,
            foreground:foreground,
            height:height,
            letterSpacing:letterSpacing,
            shadows:shadows,
            textBaseline:textBaseline,
            textStyle:textStyle,
            wordSpacing:wordSpacing,
            
       )
    );
  }
}