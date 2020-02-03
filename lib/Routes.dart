import 'package:flutter/material.dart';
import 'package:flutter_practice_firebase/screen/BookRecordVotePage.dart';
import 'package:flutter_practice_firebase/screen/MovieRecordVotePage.dart';
import 'package:flutter_practice_firebase/screen/MusicianRecordVotePage.dart';

class Routes {
  static final home = BookRecordVotePage();
  static final routes = <String, WidgetBuilder>{
    '/book': (context) => BookRecordVotePage(),
    '/movie': (context) => MovieRecordVotePage(),
    '/musician': (context) => MusicianRecordVotePage(),
  };
}