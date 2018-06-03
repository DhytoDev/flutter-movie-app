import 'package:flutter/material.dart';
import 'package:flutter_movie_app/utils/const.dart';
import 'package:flutter_movie_app/data/model/movie.dart';
import 'package:flutter_movie_app/ui/pages/detail_page.dart';
import 'package:flutter_movie_app/ui/widget/my_text_styles.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
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
          ),
        );

    final _grid =
        ScopedModelDescendant<MovieModel>(builder: (context, child, model) {
      return Container(
        child: model.isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                padding: const EdgeInsets.all(16.0),
                crossAxisCount: 3,
                childAspectRatio: 2 / 3.5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children:
                    model.movies.map((movie) => _createTile(movie)).toList(),

              ),
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: _grid,
    );
  }

  _printModel(MovieModel model) {
    print('title1 : ${model.movies.forEach((movie) => movie.title)}');
  }
}
