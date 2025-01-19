import 'package:flutter/material.dart';
import 'package:school/enseigant/emploiensg.dart';
import 'package:school/enseigant/note/class_mat.dart';
import 'package:school/enseigant/registre/mat.dart';
import 'package:school/enseigant/profil_page_enseignat.dart';

class HomeEnseigant extends StatefulWidget {
  const HomeEnseigant({super.key});

  @override
  State<HomeEnseigant> createState() => _HomeEnseigantState();
}

class _HomeEnseigantState extends State<HomeEnseigant> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.lightBlue;
    return Scaffold(
      body: Container(
        color: Colors.white, // Couleur de fond de la page
        child: Stack(
          children: [
            // Image de fond
            Positioned.fill(
              child: Image.asset(
                "assets/back.png", // Chemin de l'image de fond
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Photo de profil (CircleAvatar)
                  GestureDetector(
                    onTap: () {
                      // Action pour ouvrir la page de profil (par exemple)
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(numCIN: '01010101',)));
                    },
                    child: CircleAvatar(
                      radius: 50, // Taille de l'avatar
                      backgroundImage: const AssetImage(
                          "assets/homme.png"), // Chemin de l'image de profil
                      backgroundColor: Colors.grey
                          .shade200, // Couleur de fond si l'image est absente
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Votre Profil",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height:
                          20), // Espace entre le profil et le reste des éléments
                  // Titre de l'espace enseignant
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'ESPACE ENSEIGNANT',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25), // Espace entre les titres
                  const Text(
                    "Bienvenue dans votre espace !",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40), // Espace entre le texte et les boutons
                  // Bouton Emploi
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Emploiensg()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Emploi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Bouton Registre
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MatPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Registre",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Bouton Notes
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const NotePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Notes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Bouton Emploi surveillance
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ajouter une action pour ce bouton
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Emploi surveillance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
