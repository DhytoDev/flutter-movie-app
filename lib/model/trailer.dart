class Trailer {
  String key;

  Trailer({this.key});

  Trailer.fromJson(Map json)
      : key = json['key'];
}

String getImageVideoUrl(String key) {
  return 'https://i1.ytimg.com/vi/$key/0.jpg';
}
