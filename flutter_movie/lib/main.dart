import 'package:flutter/material.dart';
import 'package:flutter_movie_app/di/inject.dart';
import 'package:flutter_movie_app/ui/pages/home_page.dart';

void main() {
  /* runApp(BlocProvider<MovieBloc>(
    bloc: MovieBloc(),
    child: MyApp(),
  ));*/

  Injection.initInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Colors.grey[900], accentColor: Colors.orangeAccent),
      home: HomePage(),
    );
  }
}
