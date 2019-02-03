import 'dart:async';
import 'dart:convert';

import 'package:flutter_movie_app/data/model/trailer.dart';
import 'package:flutter_movie_app/utils/const.dart';
import 'package:http/http.dart' as http;

MovieRepo movieRepo = MovieRepoImpl();

abstract class MovieRepo {
  Future<List<Trailer>> fetchMovieTrailers(int movieId);
}

class MovieRepoImpl implements MovieRepo {
  @override
  Future<List<Trailer>> fetchMovieTrailers(int movieId) async {
    final url = '$BASE_URL/$movieId/videos?api_key=$API_KEY';

    List<Trailer> trailers = [];

    var response = await http
        .get(url)
        .then((response) => response.body)
        .then(json.decode)
        .then((map) => map['results']);

    response.forEach((trailer) => trailers.add(Trailer.fromJson(trailer)));

    return trailers;
  }
}
