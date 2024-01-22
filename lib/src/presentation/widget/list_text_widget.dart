import 'package:flutter/material.dart';

TextStyle styleText({required double size}) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}

AnimatedDefaultTextStyle animatedDefaultTextStyle({
  required String nameOfField,
  required bool isExpanded,
  int? text,
  bool? isTemperature,
}) {
  String? degrees() {
    if (isTemperature != null) {
      return '°';
    }
    return '';
  }

  return AnimatedDefaultTextStyle(
    duration: const Duration(milliseconds: 300),
    style: !isExpanded ? styleText(size: 16.0) : styleText(size: 24.0),
    child: Text(
      '$nameOfField - ${text ?? "N/A"}${degrees()}',
    ),
  );
}
