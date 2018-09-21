import 'package:flutter_movie_app/data/bloc/bloc_provider.dart';
import 'package:flutter_movie_app/data/model/movie_response.dart';
import 'package:flutter_movie_app/data/repository/movie_repo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc implements BlocBase {
  PublishSubject<List<Movie>> _moviesController = PublishSubject<List<Movie>>();

  Sink<List<Movie>> get _inMoviesList => _moviesController.sink;

  Stream<List<Movie>> get outMoviesList => _moviesController.stream;

  PublishSubject<int> _indexController = PublishSubject<int>();

  Sink<int> get inMovieIndex => _indexController.sink;

  PublishSubject<void> _fetchMoviesController = PublishSubject<void>();

  MovieBloc() {
    _handleFetchedPage();
  }

  @override
  void dispose() {
    _moviesController.close();
    _indexController.close();
    _fetchMoviesController.close();
  }

  void _handleFetchedPage() {
    List<Movie> movies = [];

    movieRepo.fetchUpcomingMovies().then((response) {
      movies.addAll(response.movies);
      if (movies.length > 0) {
        _inMoviesList.add(movies);
      }
    });
  }
}
