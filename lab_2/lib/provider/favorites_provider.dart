import 'package:flutter/material.dart';
import 'package:lab_2/model/joke.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Joke> _favourites = [];

  List<Joke> get favorites => _favourites;

  void addFavorites(Joke joke) {
    if (!_favourites.contains(joke)) {
      _favourites.add(joke);
      notifyListeners();
    }
  }

  void removeFavorite(Joke joke) {
    _favourites.remove(joke);
    notifyListeners();
  }
}
