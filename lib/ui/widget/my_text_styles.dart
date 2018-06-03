import 'package:flutter/material.dart';

//abstract class MyTextSyle {
  text(String text,
          {Color color = Colors.white70,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false,
          TextAlign textAlign = TextAlign.left}) =>
      Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Merriweather'),
        ),
      );
//}
