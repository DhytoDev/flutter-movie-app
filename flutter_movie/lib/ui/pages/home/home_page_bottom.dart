import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/ui/pages/detail_page.dart';

class HomePageBottom extends StatelessWidget {
  final MovieBloc bloc;

  const HomePageBottom({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _createTile(Movie movie) => Material(
          shadowColor: Colors.grey[500],
          elevation: 15.0,
          borderRadius: BorderRadius.circular(8),
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
                  Image.network(
                    '$POSTER_PATH_URL${movie.posterPath}',
                    fit: BoxFit.cover,
                    scale: 1.5,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: Center(
                        child: Text(
                          movie.title,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 12.0, fontFamily: 'Merriweather'),
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

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Now Playing',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Text('VIEW ALL', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints(maxHeight: 250),
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: bloc.moviesStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (!snapshot.hasData || snapshot.hasError)
                return CircularProgressIndicator();

              List<Movie> movies = snapshot.data;

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _createTile(movies[index]),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
