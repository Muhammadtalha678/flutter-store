
import 'package:flutter/material.dart';
// import 'package:jalalstore/enum/route_enum.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';



var  myDefaultColor = Colors.grey.shade100;
var url = "http://192.168.0.119:8000/api/v1/jalalStore";
var token = "eyJpdiI6IkNIbVdtc0xXVHIvWEpraXpxTlBQc3c9PSIsInZhbHVlIjoiRk1JNXRBRHMvdGREOExjSUJVcG9jZz09IiwibWFjIjoiZmE0Nzk2YmIwZWI1MTJjZWU2NWIxYjg1YjI5ODk3NDU0YWY3MDkyNGQ4ZjZmNjMzOTQ1NjQ4MTQ2NjY4MmZlYSIsInRhZyI6IiJ9";
var authtoken = "eyJpdiI6IkdaSjQvblhZcHZVVzdBTGx2ZFY0RFE9PSIsInZhbHVlIjoicXhwSTR1cmdEbmFuWXA2bWd6aSttUT09IiwibWFjIjoiYjUxODQ2MjZhZmE5MDE1ZDUxM2NmZjVkMDVlMjA1OTBjM2FjYjUxZGVlMTNlZTZmNDhiOWQ2ZmRiY2Y5NzgyMCIsInRhZyI6IiJ9";

// Navigation route = Navigation();
 final RegExp emailRegx = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+"
 );

// var widthMediaQuery = MediaQuery.of(context).size.width;
// Future<List<dynamic>> categories = getCategories();