import 'package:flutter/material.dart';
import 'package:school/LoginScreen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Contenu principal
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/educ.gif', //
                  fit: BoxFit.cover,
                  width: 500,
                  height: 300, // Ajuste la hauteur selon ton besoin
                ),
              ),
            ],
          ),
          // Bouton en bas
          Positioned(
            bottom: 50, // Place le bouton à 50 pixels du bas
            left: 20,
            right: 20,
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Colors.lightBlue,
                ),
                child: Text(
                  "COMMENCER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
