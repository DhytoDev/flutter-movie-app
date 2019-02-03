import 'package:flutter/material.dart';
import 'package:flutter_movie_app/di/inject.dart';
import 'package:flutter_movie_app/ui/pages/detail_page.dart';
import 'package:flutter_movie_app/ui/widget/my_text_styles.dart';
import 'package:flutter_movie_app/utils/const.dart';
import 'package:movie_bloc/src/bloc/movie_bloc.dart';
import 'package:movie_bloc/src/model/movie.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieBloc bloc = Injection.injector.get<MovieBloc>();

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

    _createTile(Movie movie) => Material(
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
                  Image.network('$POSTER_PATH_URL${movie.posterPath}',
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
        );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: StreamBuilder(
        stream: bloc.moviesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final movies = snapshot.data;

          return GridView.count(
            padding: const EdgeInsets.all(16.0),
            crossAxisCount: 3,
            childAspectRatio: 2 / 3.5,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: movies.map((movie) => _createTile(movie)).toList(),
          );
        },
      ),
    );
  }
}
