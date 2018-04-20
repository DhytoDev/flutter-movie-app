import 'package:flutter/material.dart';
import 'package:flutter_movie_app/movie.dart';
import 'package:meta/meta.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  final String posterPath = 'https://image.tmdb.org/t/p/w185';
  final String backdropPath = 'https://image.tmdb.org/t/p/w500';

  final double _appBarHeight = 256.0;

  DetailPage({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('overview : ${movie.overview}');

    final _poster = Material(
      shadowColor: Colors.grey[500],
      elevation: 15.0,
      child: InkWell(
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Image.network('$posterPath${movie.posterPath}',
                  fit: BoxFit.cover, width: 100.0, height: 150.0),
            ],
          ),
        ),
      ),
    );

    final _description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text('${movie.title}',
            isBold: true,
            size: 20.0,
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            color: Colors.white),
        Padding(
          padding: EdgeInsets.only(left: 16.0, top: 8.0),
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
                child: Icon(Icons.stars, color: Theme.of(context).accentColor, size: 30.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(flex: 2, child: _poster),
          Flexible(flex: 3, child: _description),
        ],
      ),
    );

    final _bottomContent = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text('Overview', size: 20.0, isBold: true, color: Colors.white),
          text('${movie.overview}',
              size: 14.0,
              padding: const EdgeInsets.only(top: 8.0),
              isBold: false, textAlign: TextAlign.justify),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
//            pinned: true,
            snap: true,
            floating: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Hero(
                    tag: movie.title,
                    child: Image.network(
                      '$backdropPath${movie.backdropPath}',
                      fit: BoxFit.cover,
                      height: _appBarHeight,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x60000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  <Widget>[_topContent, _bottomContent]))
        ],
      ),
    );
  }

  ///create text widget
  text(String text,
          {Color color = Colors.white70,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false, TextAlign textAlign = TextAlign.left}) =>
      Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: color,
            fontSize: size.toDouble(),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
}
