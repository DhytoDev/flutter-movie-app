import 'dart:async';
import 'dart:convert';

import 'package:flutter_movie_app/data/model/movie_response.dart';
import 'package:flutter_movie_app/utils/const.dart';
import 'package:http/http.dart' as http;

MovieRepo movieRepo = MovieRepoImpl();

abstract class MovieRepo {
  Future<MovieResponse> fetchUpcomingMovies();
}

class MovieRepoImpl implements MovieRepo {
  @override
  Future<MovieResponse> fetchUpcomingMovies() async {
    /*final uri = Uri.https(BASE_URL, 'upcoming', <String, String>{
      'api_key': API_KEY,
      'languange': 'en-US',
      'page': '$pageIndex',
    });*/

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
