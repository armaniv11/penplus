import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum Status { success, failed, retry }

Widget customFlushBar(BuildContext context,
    {required String subtitle,
    String title = "Success!!",
    Color bgColor = Colors.grey,
    int duration = 3,
    bool willPop = false}) {
  return Flushbar(
    boxShadows: const [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(
          5.0,
          5.0,
        ),
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ), //BoxShadow
      BoxShadow(
        color: Colors.white,
        offset: Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //BoxShadow
    ],
    // barBlur: 5.0,
    margin: const EdgeInsets.all(10),
    borderRadius: BorderRadius.circular(20),
    // padding: const EdgeInsets.all(8),
    title: title,
    message: subtitle,
    duration: Duration(seconds: duration),
    backgroundColor: bgColor,
  )..show(context).then((value) {
      print("It ran");
      if (willPop) {
        Navigator.of(context).pop();
      }
    });
}
