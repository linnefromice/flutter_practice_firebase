import 'package:flutter/material.dart';
import 'package:flutter_practice_firebase/screen/BookRecordVotePage.dart';
import 'package:flutter_practice_firebase/screen/MovieRecordVotePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookRecordVotePage(),
      routes: <String, WidgetBuilder>{
        '/book': (context) => BookRecordVotePage(),
        '/movie': (context) => MovieRecordVotePage(),
      },
    );
  }
}
