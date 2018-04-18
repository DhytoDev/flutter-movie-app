class Movie {
  String id,
      title,
      popularity,
      posterPath,
      backdropPath,
      overview,
      releaseDate,
      voteCount,
      voteAverage;

  Movie({this.title, this.posterPath});

  Movie.fromJson(Map json)
      :
        title = json['title'],
        posterPath = json['poster_path'];
}


/*
final List<Movie> movies = [
  Movie('Fifty Shades Freed',
      'https://image.tmdb.org/t/p/w1280/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg'),
  Movie('Coco',
      'https://image.tmdb.org/t/p/w1280/eKi8dIrr8voobbaGzDpe8w0PVbC.jpg'),
  Movie('Start Wars: The Last Jedi',
      'https://image.tmdb.org/t/p/w1280/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg'),
  Movie('Thor: Ragnarok',
      'https://image.tmdb.org/t/p/w1280/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg'),
  Movie('Beauty and The Beast',
      'https://image.tmdb.org/t/p/w1280/tWqifoYuwLETmmasnGHO7xBjEtt.jpg'),
]; */
