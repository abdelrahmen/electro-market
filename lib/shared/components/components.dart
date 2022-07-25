import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTO(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateWithNoBack(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(3),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Future<bool?> flutterToast({
  required String msg,
  Color color = Colors.red,
  ToastGravity position = ToastGravity.BOTTOM,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: position,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

Widget mySeparator() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 1,
        color: Colors.grey[300],
      ),
    );
