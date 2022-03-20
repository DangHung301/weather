import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(
    {double fontSize = 36,
    Color? color,
    FontWeight fontWeight = FontWeight.w300}) {
  return GoogleFonts.montserrat(
      fontSize: fontSize, fontWeight: fontWeight, color: color ?? Colors.white,);
}
