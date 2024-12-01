import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lab_2/model/joke.dart';

class ApiService {
  static Future<http.Response> getJokesTypes() async {
    var response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/types'));
    return response;
  }

  static Future<List<Joke>> getJokes({required String type}) async {
    try {
      var service = 'https://official-joke-api.appspot.com/jokes/$type/ten';
      var response = await http.get(Uri.parse(service));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return List<Joke>.from(data.map((json) => Joke.fromJson(json)));
      } else {
        return List.empty();
      }
    } on Exception catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  static Future<Joke> getJokeOfTheDay() async {
    try {
      var service = 'https://official-joke-аpi.appspot.com/random_joke';
      var response = await http.get(Uri.parse(service));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data.map((json) => Joke.fromJson(json));
      } else {
        return Joke(type: '', setup: '', punchline: '');
      }
    } catch (e) {
      log(e.toString());
      return Joke(type: '', setup: '', punchline: '');
    }
  }
}
