import 'package:flutter/material.dart';

abstract class Styles {

  static const TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
  );

  static Widget text(String txtString) {
    return Text(
        txtString,
        style: Styles.textStyle
    );
  }
}
