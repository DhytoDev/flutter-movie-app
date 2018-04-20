import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/movie.dart';
import 'package:flutter_movie_app/detail_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://api.themoviedb.org/3/movie/upcoming/';
  final String key = '678ef42a1b584848591cbd02ac3899c3';
  final String posterPath = 'https://image.tmdb.org/t/p/w185';

  final List<Movie> movies = List();

  @override
  void initState() {
    super.initState();
    this.fetchUpComingMovies();
  }

  Future<String> fetchUpComingMovies() async {
    http
        .get('$url?api_key=$key')
        .then((response) => (response.body))
        .then(json.decode)
        .then((map) => map["results"])
        .then((movies) => movies.forEach(addMovie));
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
      title: Text(
        'Movie App',
        style: TextStyle(color: Colors.white),
      ),
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailPage(movie: movie),
                ));
              },
              child: Card(
                elevation: 0.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Image.network('$posterPath${movie.posterPath}',
                        fit: BoxFit.cover),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: Center(
                          child: Text(
                            movie.title,
                            softWrap: true,
                            style: TextStyle(fontSize: 11.0),
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

    print(movies);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: _grid,
    );

  }
}
