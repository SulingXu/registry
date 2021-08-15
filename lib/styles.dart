import 'package:flutter/material.dart';

abstract class Styles {

  static const TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15)
  );

  static ButtonStyle unCheckedOutbuttonColor = ElevatedButton.styleFrom(
    primary: Colors.green, // background
    onPrimary: Colors.white, // foreground
  );

  static ButtonStyle CheckedOutbuttonColor = ElevatedButton.styleFrom(
    primary: Colors.grey, // background
    onPrimary: Colors.black, // foreground
  );

  static Widget text(String txtString) {
    return Text(
        txtString,
        style: Styles.textStyle
    );
  }

  static Widget textRowWith(String prefix, String showString) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Styles.text(prefix),
        const SizedBox(width: 10),
        Styles.text(showString),
      ],
    );
  }

  static Widget paddingWithText(String txt) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: text(txt),
    );
  }

  static Widget paddingWithTextRow(String prefix, String showString) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: textRowWith(prefix, showString),
    );
  }

}
