import 'package:flutter/material.dart';
import 'package:flutter_movie_app/movie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    createTile(Movie movie) => Material(
      shadowColor: Colors.grey[500],
      elevation: 15.0,
      child: InkWell(
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Image.network(movie.posterPath, fit: BoxFit.cover),
              Expanded(
                child:  Container(
                  margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child:  Center(
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
    );

    final grid = GridView.count(
      padding: const EdgeInsets.all(16.0),
      crossAxisCount: 3,
      childAspectRatio: 2 / 3.5,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      children: movies.map((movie) => createTile(movie)).toList(),
    );

    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: grid,
    );
  }
}
