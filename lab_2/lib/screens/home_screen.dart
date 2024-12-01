import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lab_2/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> types = [];

  @override
  void initState() {
    super.initState();
    getTypes();
  }

  void getTypes() async {
    ApiService.getJokesTypes().then((response) {
      var data = List.from(json.decode(response.body));
      setState(() {
        types = data.map((type) => type.toString()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of jokes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: types.length,
          itemBuilder: (context, index) {
            final type = types[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(type),
                tileColor: const Color(0xFF4A314D),
                textColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, "jokesScreen", arguments: type);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
