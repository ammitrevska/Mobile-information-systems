import 'package:flutter/material.dart';
import 'package:lab_1/models/clothes.dart';

class DetailsPage extends StatelessWidget {
  final Clothes clothes;
  const DetailsPage({super.key, required this.clothes});

  @override
  Widget build(BuildContext context) {
    final List<String> descriptions = clothes.description.split(',');

    return Theme(
      data: Theme.of(context)
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.transparent)),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    clothes.url,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  clothes.name,
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: descriptions.map((desc) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ', // Bullet symbol
                          style: TextStyle(fontSize: 18),
                        ),
                        Expanded(
                          child: Text(
                            desc.trim(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  '${clothes.price}' ' euro',
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
