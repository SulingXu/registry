import 'package:flutter/material.dart';

abstract class Styles {

  static const TextStyle middleTextWithDefaultColor = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle smallTextWithDefaultColor = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle extralSmallTextWithRedColor = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.red,
  );

  static const TextStyle SmallTextWithRedColor = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.red,
  );

  static const TextStyle extralSmallTextWithYellowColor = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Color(0xFFF6CE02),
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
  );

  static ButtonStyle unCheckedOutbuttonColor = ElevatedButton.styleFrom(
    primary: Colors.green, // background
    onPrimary: Colors.white, // foreground
  );

  static ButtonStyle CheckedOutbuttonColor = ElevatedButton.styleFrom(
    primary: Colors.grey, // background
    onPrimary: Colors.black, // foreground
  );

  static Widget text(String txtString, TextStyle txtStyle) {
    return Text(
        txtString,
        style: txtStyle
    );
  }

  static Widget textRowWith(String prefix, String showString) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Styles.text(prefix, Styles.middleTextWithDefaultColor),
        const SizedBox(width: 10),
        Styles.text(showString, Styles.middleTextWithDefaultColor),
      ],
    );
  }

  static Widget paddingWithText(String txt) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: text(txt, Styles.middleTextWithDefaultColor),
    );
  }

  static Widget paddingWithTextRow(String prefix, String showString) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: textRowWith(prefix, showString),
    );
  }
}
