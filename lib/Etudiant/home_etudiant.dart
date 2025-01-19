import 'package:flutter/material.dart';
import 'package:school/Etudiant/absence.dart';
import 'package:school/Etudiant/emploi_etudiant.dart';
import 'package:school/Etudiant/note_etudiant.dart';
import 'package:school/enseigant/profil_page_enseignat.dart';

class HomeEtudiant extends StatefulWidget {
  const HomeEtudiant({super.key});

  @override
  State<HomeEtudiant> createState() => _HomeEtudiantState();
}

class _HomeEtudiantState extends State<HomeEtudiant> {
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
                "assets/back.png", // Chemin de l'image
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo au-dessus
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/lojo.jpg", // Chemin du logo
                      width: 100, // Taille du logo
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
 // Espace pour le profil avec une icône ou un bouton
                  GestureDetector(
                    onTap: () {
                      // Action pour ouvrir la page de profil (par exemple)
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/etud.png'), // Image de profil
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Titre
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'ESPACE ETUDIANT',
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
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenue dans votre espace !",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                

                  // Bouton pour accéder à l'emploi du temps
                  _buildCustomButton(
                    context,
                    "Emploi",
                    Icons.calendar_today,
                    () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => EmploiEtudiant()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Bouton pour accéder aux absences
                  _buildCustomButton(
                    context,
                    "Absences",
                    Icons.error_outline,
                    () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AbsencesPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Bouton pour accéder aux notes
                  _buildCustomButton(
                    context,
                    "Notes",
                    Icons.grade,
                    () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NotesPageEtudiant()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour générer un bouton personnalisé avec une icône
  Widget _buildCustomButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:Colors.lightBlue,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
