import 'package:flutter/material.dart';

class TextWidget {

  static const fontSizeXS = 12.0;
  static const fontSizeS = 16.0;
  static const fontSizeM = 18.0;
  static const fontSizeL = 20.0;
  static const fontSizeXL = 24.0;
  static const colorAlternate = Colors.grey;

  static Text textXS(String text) {
    return _text(text, fontSizeXS);
  }

  static Text textXSAlternate(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: fontSizeXS,
        color: colorAlternate,
      ),
    );
  }

  static Text textS(String text) {
    return _text(text, fontSizeS);
  }

  static Text textM(String text) {
    return _text(text, fontSizeM);
  }

  static Text textL(String text) {
    return _text(text, fontSizeL);
  }

  static Text textLCenter(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: fontSizeL,
      ),
      textAlign: TextAlign.center,
    );
  }

  static Text textXLCenter(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: fontSizeXL,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  static Text textXL(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: fontSizeXL,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Text _text(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
    );
  }

}