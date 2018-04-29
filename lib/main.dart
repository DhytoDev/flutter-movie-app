import 'package:flutter/material.dart';
import 'package:flutter_movie_app/home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Colors.grey[900],
          accentColor: Colors.orangeAccent),
      home: HomePage(),
    );
  }
}
