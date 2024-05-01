import 'package:flutter/material.dart';

Widget header(String title, context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.chevron_left, size: 40.0, color: Colors.black)),
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
  );
}
