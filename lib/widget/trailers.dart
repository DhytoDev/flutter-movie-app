import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/const.dart';
import 'package:flutter_movie_app/model/trailer.dart';
import 'package:flutter_movie_app/widget/my_text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Trailers extends StatefulWidget {
  final int id;

  Trailers(this.id);

  @override
  _TrailerItemState createState() => new _TrailerItemState(id);
}

class _TrailerItemState extends State<Trailers> {
  final List<Trailer> trailers = List();

  final int id;

  _TrailerItemState(this.id);

  @override
  void initState() {
    super.initState();
    this.fetchMovieTrailers();
  }

  Future<String> fetchMovieTrailers() async {
    String url = '$BASE_URL${id.toString()}/videos?api_key=$API_KEY';

    http
        .get(url)
        .then((response) => (response.body))
        .then(json.decode)
        .then((map) => map["results"])
        .then((trailers) => trailers.forEach(addTrailer))
        .catchError((Exception e) => debugPrint('Error ${e.toString()}'));

    return 'Success';
  }

  void addTrailer(item) {
    setState(() {
      trailers.add(Trailer.fromJson(item));
    });
  }

  _launchURL(String key) async {
    final url = 'https://www.youtube.com/watch?v=$key';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    _createThumbnail(Trailer trailer) => Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: Material(
            elevation: 5.0,
            child: InkWell(
              onTap: () {
                _launchURL(trailer.key);
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.network(getImageVideoUrl(trailer.key),
                      fit: BoxFit.fill, width: 200.0, height: 150.0),
                  Center(
                    child: Icon(Icons.play_circle_outline,
                        size: 50.0, color: Colors.grey[300]),
                  )
                ],
              ),
            ),
          ),
        );

    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text('Trailers', size: 18.0, isBold: true, color: Colors.white),
          Container(
            constraints: const BoxConstraints(maxHeight: 150.0),
            margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: trailers
                    .map((trailer) => _createThumbnail(trailer))
                    .toList()),
          )
        ],
      ),
    );
  }
}
