import 'package:flutter/material.dart';
import 'package:flutter_practice_firebase/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Routes.home,
      routes: Routes.routes
    );
  }
}
