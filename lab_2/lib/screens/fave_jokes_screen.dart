import 'package:flutter/material.dart';
import 'package:lab_2/provider/favorites_provider.dart';
import 'package:provider/provider.dart';

class FaveJokesScreen extends StatelessWidget {
  const FaveJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Jokes'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite jokes yet!',
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final joke = favorites[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            joke.setup,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            joke.punchline,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
