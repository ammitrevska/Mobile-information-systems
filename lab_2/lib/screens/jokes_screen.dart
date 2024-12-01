import 'package:flutter/material.dart';
import 'package:lab_2/model/joke.dart';
import 'package:lab_2/service/api_service.dart';

class JokesScreen extends StatefulWidget {
  final String type;
  const JokesScreen({super.key, required this.type});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  List<Joke> jokes = [];
  bool isLoading = true;

  void getJokes() async {
    setState(() {
      isLoading = true;
    });

    List<Joke> fetchedJokes = await ApiService.getJokes(type: widget.type);

    setState(() {
      jokes = fetchedJokes;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} jokes'),
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
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
