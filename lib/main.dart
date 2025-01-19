import 'package:flutter/material.dart';
import 'package:school/Etudiant/home_etudiant.dart';
import 'package:school/charge.dart';
import 'package:school/get_start.dart';
import 'package:school/enseigant/profil_page_enseignat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:IntroScreen(),
    );
  }
}

