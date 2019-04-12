import 'dart:async';

import 'package:core/core.dart';

import 'endpoint.dart';

class TMDBApi {
  Future<MovieResponse> getNowPlayingMovies() async {
    var response = await Config.instance()
        .get('/now_playing', queryParameters: {"api_key": API_KEY});

    return MovieResponse.fromJSON(response.data);
  }

  Future<TrailerResponse> getTrailersByMovieId(int movieId) async {
    var response = await Config.instance()
        .get('/$movieId/videos', queryParameters: {"api_key": API_KEY});

    return TrailerResponse.fromJson(response.data);
  }
}
