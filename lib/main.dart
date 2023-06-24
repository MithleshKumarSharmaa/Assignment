// import 'package:assignment/add.dart';
import 'package:assignment/add_comments.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddCommentScreen(),

      // home: AddScreen(),
    );
  }
}
