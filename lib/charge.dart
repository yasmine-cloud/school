import 'package:flutter/material.dart';

class ImageLoadingPage extends StatefulWidget {
  @override
  _ImageLoadingPageState createState() => _ImageLoadingPageState();
}

class _ImageLoadingPageState extends State<ImageLoadingPage> {
  bool _isLoading = true;

  // Exemple pour simuler la fin du chargement des données
  void finishLoading() {
    setState(() {
      _isLoading = false; // Met fin au chargement
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: Center(
        child: _isLoading
            ? Image.asset(
                'assets/Skateboarding.gif', // Chemin du GIF
                width: 800,
                height: 800,
              )
            : Text(
                'Chargement terminé !',
                style: TextStyle(fontSize: 20),
              ),
      ),
      floatingActionButton: _isLoading
          ? FloatingActionButton(
              onPressed: finishLoading, // Simule la fin du chargement
              child: Icon(Icons.check),
            )
          : null,
    );
  }
}
