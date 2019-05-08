import 'package:core/core.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web_movie/di/inject.dart';

void main() {
  Injection.initInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Movie App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final MovieBloc bloc = Injection.injector.get<MovieBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: bloc.errorMessage(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return width >= 600
                ? MovieTile(
                    bloc: bloc,
                    count: 4,
                  )
                : MovieTile(bloc: bloc, count: 2);
          }

          return Text('Error : ${snapshot.data}');
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    @required this.bloc,
    @required this.count,
  }) : super(key: key);

  final MovieBloc bloc;
  final int count;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.getMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          padding: const EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: count,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2 / 3.5,
            children: snapshot.data
                .map((movie) => _createTile(movie, context))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _createTile(Movie movie, BuildContext context) => Material(
        shadowColor: Colors.grey[500],
        elevation: 15.0,
        borderRadius: BorderRadius.circular(8),
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.network(
                '$POSTER_PATH_URL${movie.posterPath}',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Center(
                    child: Text(
                      movie.title,
                      softWrap: true,
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
