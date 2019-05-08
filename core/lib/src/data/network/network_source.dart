import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import 'endpoint.dart';

class MovieNetworkSource {
  Future<MovieResponse> getNowPlayingMovies() async {
    try {
      var response = await Config.instance()
          .get('/now_playing', queryParameters: {"api_key": API_KEY});

      print(response);

      return MovieResponse.fromJSON(response.data);
    } catch (error) {
      return MovieResponse.errorValue(error.toString());
    }
  }

  Future<TrailerResponse> getTrailersByMovieId(int movieId) async {
    var response = await Config.instance()
        .get('/$movieId/videos', queryParameters: {"api_key": API_KEY});

    return TrailerResponse.fromJson(response.data);
  }

  Future<MovieResponse> getMovies() async {
    final url = '$BASE_URL/upcoming?api_key=$API_KEY';

    var response = await http
        .get(url)
        .then((response) => (response.body))
        .then(json.decode)
        .catchError((Exception e) => print('Error ${e.toString()}'));

    print(response.toString());

    MovieResponse movieResponse = MovieResponse.fromJSON(response);

    return movieResponse;
  }
}
