import 'package:flutter/material.dart';

void showSnackbarMsg(BuildContext context, String message,) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 1500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}