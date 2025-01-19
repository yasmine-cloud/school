import 'package:flutter/material.dart';
import 'package:school/API/PareXML.dart';
import 'package:school/API/classes.dart';
import 'package:school/API/httpreq.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  final String numCIN; // Paramètre pour le NumCIN

  // Constructeur de la page avec le NumCIN
  ProfilePage({required this.numCIN});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Enseignant>(
      future: fetchEnseignant(
          numCIN), // Appel de la méthode fetch pour récupérer les données
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Assurez-vous que snapshot.data contient un objet Enseignant
          final enseignant = snapshot.data!;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: const Text(
                "Enseignant - Profil",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // En-tête avec photo et nom
                  Stack(
                    children: [
                      Container(
                        height: 220,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightBlue, Color(0xFF74C0FC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  size: 65,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              /*CircleAvatar(
  radius: 65,
  backgroundColor: Colors.white,
  child: ClipOval(
    child: enseignant.Photo != null && enseignant.Photo.isNotEmpty
        ? Image.network(
            'http://mserp.tn:85/enseignant01.asmx/GetProf/${enseignant.Photo}', // Remplacez par l'URL complète
            fit: BoxFit.cover,
            width: 130, // Le diamètre du CircleAvatar
            height: 130,
          )
        : Icon(
            Icons.person,
            size: 65,
            color: Colors.lightBlue,
          ),
  ),
),*/

                              const SizedBox(height: 12),
                              // Affichez le nom de l'enseignant
                              Text(
                                enseignant
                                    .Nom, // Assurez-vous que l'objet Enseignant a un champ 'nom'
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Informations principales
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildInfoRow(
                                Icons.person_outline, "Nom", enseignant.Nom),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.person_outline, "Prenom",
                                enseignant.Prenom),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.card_membership, "Matricule",
                                enseignant.Matcle),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.email_outlined, "Email",
                                enseignant.Email ?? "Email non disponible"),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.location_on_outlined,
                                "Lieu de naissance", enseignant.LieuNai),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(
                                Icons.cake_outlined,
                                "Date de naissance",
                                formatDateTime(enseignant.DatNai)),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.location_on_outlined, "Sexe",
                                (enseignant.Sexe == 1 ? "Femme" : "Homme")),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.flag_outlined, "Nation",
                                enseignant.Nation),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.home_outlined, "Adresse",
                                enseignant.Adresse),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.phone_outlined, "Telephone",
                                enseignant.Tel),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.location_on_outlined,
                                "Lieu de naissance", enseignant.LieuNai),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(
                                Icons.business_outlined,
                                "Nom de departement",
                                enseignant.libDepartement),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.business_outlined,
                                "Departement", enseignant.Departement),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.cake_outlined, "Date de Garde",
                                formatDateTime(enseignant.DatGrade)),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.cake_outlined, "Date de An",
                                formatDateTime(enseignant.DatAn)),
                            const Divider(thickness: 1, color: Colors.grey),
                            _buildInfoRow(Icons.star_border_outlined, "Garde",
                                enseignant.libgrade),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Boutons d'action
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          _showLogoutConfirmationDialog(context);
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          "Se déconnecter",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('Aucune donnée disponible'));
      },
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy')
        .format(dateTime); // Choisissez le format qui vous convient
  }

  // Widget pour construire les lignes d'informations
  Widget _buildInfoRow(IconData icon, String label, dynamic value) {
    String displayValue = value is DateTime
        ? formatDateTime(value) // Si la valeur est un DateTime, on la formate
        : value.toString(); // Sinon, on l'affiche tel quel

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.lightBlue, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayValue,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour afficher le dialogue de déconnexion
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Voulez-vous vraiment vous déconnecter ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
                Navigator.of(context).pop(); // Déconnexion
              },
              child: const Text("Se déconnecter"),
            ),
          ],
        );
      },
    );
  }

  // Méthode fetch pour récupérer les informations de l'enseignant par NumCIN
  Future<Enseignant> fetchEnseignant(String numCIN) async {
    try {
      final response = await THttpHelper.get<Enseignant>(
        'GetProf', // Nom de l'endpoint
        queryParameters: {
          'NumCIN': numCIN
        }, // Passage du NumCIN en paramètre de la requête
        parseEnseignant, // Méthode pour parser les données de l'enseignant
      );
      print('Enseignant récupéré: ${response.first}');
      return response.first; // Retourne l'objet Enseignant
    } catch (e) {
      throw Exception('Erreur lors de la récupération des données: $e');
    }
  }
}
