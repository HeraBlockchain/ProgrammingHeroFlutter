import 'package:flutter/material.dart';
import 'package:programming_hero_quiz/ui/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(0, 2, 49, 1.0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Home Page'),
    );
  }
}
