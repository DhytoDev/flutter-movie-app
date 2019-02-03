import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_bloc/src/model/movie.dart';
import 'package:movie_bloc/src/model/trailer.dart';

import 'endpoint.dart';

class TMDBApi {
  Future<MovieResponse> getMovies() async {
    final url = '$BASE_URL/upcoming?api_key=$API_KEY';

    var response = await http
        .get(url)
        .then((response) => (response.body))
        .then(json.decode)
        .catchError((Exception e) => print('Error ${e.toString()}'));

    MovieResponse movieResponse = MovieResponse.fromJSON(response);

    return movieResponse;
  }

  Future<List<Trailer>> getTrailersByMovieId(int movieId) async {
    final url = '$BASE_URL/$movieId/videos?api_key=$API_KEY';

    List<Trailer> trailers = [];

    var response = await http
        .get(url)
        .then((response) => response.body)
        .then(json.decode)
        .then((map) => map['results']);

    print(response);

    response.forEach((trailer) => trailers.add(Trailer.fromJson(trailer)));

    return trailers;
  }
}
