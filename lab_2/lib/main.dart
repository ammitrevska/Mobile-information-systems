import 'package:flutter/material.dart';
import 'package:lab_2/firebase/firebase_api.dart';
import 'package:lab_2/provider/favorites_provider.dart';
import 'package:lab_2/screens/fave_jokes_screen.dart';
import 'package:lab_2/screens/home_screen.dart';
import 'package:lab_2/screens/joke_of_day.dart';
import 'package:lab_2/screens/jokes_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF4A314D),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFA8BA9A),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        cardTheme: const CardTheme(color: Color(0xFF4A314D)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      navigatorKey: navigatorKey,
      routes: {
        'jokesScreen': (context) {
          final String type =
              ModalRoute.of(context)?.settings.arguments as String;
          return JokesScreen(type: type);
        },
        'jokeOfTheDay': (context) {
          return const JokeOfDay();
        },
        'favoritesScreen': (context) {
          return const FaveJokesScreen();
        }
      },
    );
  }
}
