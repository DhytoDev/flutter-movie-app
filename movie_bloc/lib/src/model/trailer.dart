class TrailerResponse {
  final int id;

  final List<Trailer> trailers;

  TrailerResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        trailers = (json['results'] as List)
            .map((trailer) => Trailer.fromJson(trailer))
            .toList();
}

class Trailer {
  String key;

  Trailer({this.key});

  Trailer.fromJson(Map<String, dynamic> json) : key = json['key'];
}

String getImageVideoUrl(String key) {
  return 'https://i1.ytimg.com/vi/$key/0.jpg';
}
