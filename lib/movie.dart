class Movie {
  int id;
  String title, posterPath, backdropPath, overview, releaseDate;
  double popularity;
  int voteCount;
  num voteAverage;

  Movie(
      {this.id,
      this.title,
      this.popularity,
      this.posterPath,
      this.backdropPath,
      this.overview,
      this.releaseDate,
      this.voteCount,
      this.voteAverage});

  Movie.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'],
        overview = json['overview'],
        releaseDate = json['release_date'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'];
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
