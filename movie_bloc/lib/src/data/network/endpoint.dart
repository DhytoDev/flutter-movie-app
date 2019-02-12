import 'package:dio/dio.dart';

const BASE_URL = 'https://api.themoviedb.org/3/movie';
const API_KEY = '678ef42a1b584848591cbd02ac3899c3';
const POSTER_PATH_URL = 'https://image.tmdb.org/t/p/w185';
const BACKDROP_PATH_URL = 'https://image.tmdb.org/t/p/w500';

class Config {
  static Dio instance() {
    Dio dio = Dio();
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;

    return dio;
  }
}
