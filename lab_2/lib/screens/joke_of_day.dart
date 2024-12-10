import 'package:flutter/material.dart';
import 'package:lab_2/model/joke.dart';
import 'package:lab_2/service/api_service.dart';

class JokeOfDay extends StatefulWidget {
  const JokeOfDay({super.key});

  @override
  State<JokeOfDay> createState() => _JokeOfDayState();
}

class _JokeOfDayState extends State<JokeOfDay> {
  bool isLoading = true;
  late Joke joke;

  @override
  void initState() {
    super.initState();
    getJoke();
  }

  void getJoke() async {
    setState(() {
      isLoading = true;
    });

    final jokeOfTheDay = await ApiService.getJokeOfTheDay();

    setState(() {
      joke = jokeOfTheDay;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke of the day'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4A314D),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        joke.setup,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        joke.punchline,
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
