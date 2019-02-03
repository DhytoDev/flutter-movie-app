import 'package:flutter/material.dart';
import 'package:flutter_movie_app/data/model/movie_response.dart';
import 'package:flutter_movie_app/ui/widget/collapsing_toolbar.dart';
import 'package:flutter_movie_app/ui/widget/my_text_styles.dart';
import 'package:flutter_movie_app/ui/widget/trailers.dart';
import 'package:flutter_movie_app/utils/const.dart';
import 'package:meta/meta.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  DetailPage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _poster = Material(
      shadowColor: Colors.grey[500],
      elevation: 15.0,
      child: InkWell(
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          child: Image.network('$POSTER_PATH_URL${movie.posterPath}',
              fit: BoxFit.cover, width: 100.0, height: 150.0),
        ),
      ),
    );

    final _description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(movie.title.isEmpty ? 'Title' : '${movie.title}',
            size: 18.0,
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            color: Colors.white),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Icon(Icons.calendar_today,
                    color: Theme.of(context).accentColor, size: 30.0),
                flex: 1,
              ),
              Flexible(
                child: text('${movie.releaseDate}',
                    isBold: false,
                    size: 14.0,
                    padding: EdgeInsets.only(left: 8.0)),
                flex: 4,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Icon(Icons.stars,
                    color: Theme.of(context).accentColor, size: 30.0),
                flex: 1,
              ),
              Flexible(
                child: text('${movie.voteAverage}/10 (${movie.voteCount})',
                    isBold: false,
                    size: 14.0,
                    padding: EdgeInsets.only(left: 8.0)),
                flex: 4,
              )
            ],
          ),
        )
      ],
    );

    final _topContent = Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(flex: 2, child: _poster),
          Flexible(flex: 3, child: _description),
        ],
      ),
    );

    final _bottomContent = Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text('Overview', size: 18.0, isBold: true, color: Colors.white),
          text('${movie.overview}',
              size: 14.0,
              padding: const EdgeInsets.only(top: 8.0),
              isBold: false,
              textAlign: TextAlign.justify),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CollapsingToolbar(
                title: '${movie.title}',
                backdrop: '$BACKDROP_PATH_URL${movie.backdropPath}'),
          ];
        },
        body: ListView(
          children: <Widget>[_topContent, _bottomContent, Trailers(movie.id)],
        ),
      ),
    );
  }
}
