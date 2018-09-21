import 'package:flutter_movie_app/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test("parses upcoming movie", () async {
    final uri = Uri.https(BASE_URL, 'upcoming', <String, String>{
      'api_key': API_KEY,
      'languange': 'en-US',
      'page': '1',
    });

    final url = '$BASE_URL/upcoming?api_key=$API_KEY';

    var response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      expect(response.body, isNotEmpty);
    }
  });
}
