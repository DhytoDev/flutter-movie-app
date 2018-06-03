import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/data/model/movie.dart';
import 'package:flutter_movie_app/utils/const.dart';

abstract class MovieRepo {
  Future<List<Movie>> fetchUpcomingMovies();
}

class MovieRepoImpl implements MovieRepo {
  @override
  Future<List<Movie>> fetchUpcomingMovies() async {
    List<Movie> movieList = [];

    String url = '${BASE_URL}upcoming?api_key=$API_KEY';

    await http
        .get(url)
        .then((response) => (response.body))
        .then(json.decode)
        .then((map) => map["results"])
        .then((movies) =>
            movies.forEach((movie) => movieList.add(Movie.fromJson(movie))))
        .catchError((Exception e) => print('Error ${e.toString()}'));

    return movieList;
  }
}
