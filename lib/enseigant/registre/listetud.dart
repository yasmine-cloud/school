import 'package:flutter/material.dart';
import 'package:school/API/PareXML.dart';
import 'package:school/API/classes.dart';
import 'package:school/API/httpreq.dart';
import 'package:intl/intl.dart';

class ListEtudiants extends StatefulWidget {
  final int classeId;
  final int matiereId;
  final DateTime dateDebut;
  final DateTime dateFin;
  final int seance;
  final String seancenom;

  const ListEtudiants({
    super.key,
    required this.classeId,
    required this.matiereId,
    required this.dateDebut,
    required this.dateFin,
    required this.seance,
    required this.seancenom,
  });

  @override
  State<ListEtudiants> createState() => _ListEtudiantsState();
}

class _ListEtudiantsState extends State<ListEtudiants> {
  List<Etudiant> students = [];
  Map<int, bool> attendance = {}; // Stocke l'état des cases à cocher pour chaque étudiant
  late String dateToday; // Stocke la date du jour

  @override
  void initState() {
    super.initState();
    dateToday = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Initialise la date du jour
    _fetchStudents(); // Récupère les étudiants pour cette classe
  }

  Future<void> _fetchStudents() async {
    try {
      final queryParameters = {'Classe': widget.classeId.toString()};
      final response = await THttpHelper.get<Etudiant>(
        'GetlstEtd',
        parseEtudiant,
        queryParameters: queryParameters,
      );
      setState(() {
        students = response;
        attendance = {for (var student in students) student.code: false}; // Initialise l'état des cases à cocher
      });
    } catch (e) {
      print("Erreur lors de l'appel de l'API: $e");
    }
  }

void _validateAttendance() async {
  // Liste des futures pour attendre la fin de toutes les requêtes
  List<Future<void>> futures = [];

  // Boucle sur les étudiants pour envoyer leurs présences ou absences
  for (var student in students) {
    final isPresent = attendance[student.code] ?? false; // Vérifie si l'étudiant est présent
final dateEff = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
print('DateEff: $dateEff');

    // Préparation des données à envoyer
    final body = {
      'DatEff': '2025-02-02', // La date actuelle
      'classe': widget.classeId.toString(),
      'Matiere': widget.matiereId.toString(),
      'seance': widget.seance.toString(),
      'etudiant': student.code.toString(),
    };

    // Ajoute la requête à la liste des futures
    futures.add(THttpHelper.postBooleen(
      'SetAbsence',
      body,
      (response) {
        // Traitez la réponse si nécessaire
        print("Réponse API pour ${student.etudiant}: $response");
      },
    ));
  }

  try {
    // Attendre que toutes les requêtes soient terminées
    await Future.wait(futures);

    // Affichage d'un message de succès après la validation de toutes les présences
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Présences validées avec succès !')),
    );
  } catch (e) {
    // Gestion d'erreur globale
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de la validation des présences: $e')),
    );
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Liste des Étudiants',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage de la date et de la période
            Column(
              children: [
                Text(
                  'Date: $dateToday',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Séance: ${widget.seancenom} - ${DateFormat('HH:mm').format(widget.dateDebut)} à ${DateFormat('HH:mm').format(widget.dateFin)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Liste des étudiants
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return GestureDetector(
                    onTap: () {
                      // Action on tap if needed (e.g., navigate or show details)
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(
                          Icons.person_rounded,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        title: Text(
                          student.etudiant,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.lightBlue,
                          ),
                        ),
                        subtitle: Text(
                          'Code: ${student.code}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Checkbox(
                          activeColor: Colors.lightBlue,
                          value: attendance[student.code],
                          onChanged: (value) {
                            setState(() {
                              attendance[student.code] = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bouton pour valider les présences
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: _validateAttendance,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Valider les Présences',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
