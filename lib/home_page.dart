import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/const.dart';
import 'package:flutter_movie_app/model/movie.dart';
import 'package:flutter_movie_app/detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/widget/my_text_styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> movies = List();

  @override
  void initState() {
    super.initState();
    this.fetchUpComingMovies();
  }

  Future<String> fetchUpComingMovies() async {

    String url = '${Const.BASE_URL}upcoming?api_key=${Const.API_KEY}' ;
    debugPrint('url = $url');

    http
        .get(url)
        .then((response) => (response.body))
        .then(json.decode)
        .then((map) => map["results"])
        .then((movies) => movies.forEach(addMovie))
        .catchError((Exception e) => debugPrint('Error ${e.toString()}'));

    return 'Success';
  }

  void addMovie(item) {
    setState(() {
      movies.add(Movie.fromJson(item));
//      print('title : ${movies.map((m) => m.title)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 5.0,
      title: text('Movie App', color: Colors.white, size: 18.0),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );

    _createTile(Movie movie) => Hero(
          tag: movie.title,
          child: Material(
            shadowColor: Colors.grey[500],
            elevation: 15.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(movie: movie),
                    ));
              },
              child: Card(
                elevation: 0.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Image.network('${Const.POSTER_PATH_URL}${movie.posterPath}',
                        fit: BoxFit.cover),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Center(
                          child: Text(
                            movie.title,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 10.0, fontFamily: 'Merriweather'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

    final _grid = GridView.count(
      padding: const EdgeInsets.all(16.0),
      crossAxisCount: 3,
      childAspectRatio: 2 / 3.5,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: movies.map((movie) => _createTile(movie)).toList(),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: _grid,
    );
  }
}
