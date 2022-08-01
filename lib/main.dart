import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reproductor_music/screen/songs_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SonList(),      
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
