import 'package:flutter/material.dart';
import 'package:school/Etudiant/home_etudiant.dart';

class NotesPageEtudiant extends StatelessWidget {
  // Exemple de données avec plusieurs notes par matière
  final Map<String, List<Map<String, dynamic>>> groupedNotes = {
    "Mathématiques": [
      {
        "note": 17.5,
        "type": "Contrôle continu",
      },
      {
        "note": 15.0,
        "type": "Examen final",
      },
    ],
    "Histoire": [
      {
        "note": 14.0,
        "type": "Examen final",
      },
    ],
    "Physique": [
      {
        "note": 15.5,
        "type": "Devoir surveillé",
      },
      {
        "note": 16.0,
        "type": "Contrôle continu",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Mes Notes",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeEtudiant(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: groupedNotes.entries.map((entry) {
            final String matiere = entry.key;
            final List<Map<String, dynamic>> notes = entry.value;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fond blanc pour la carte
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre de la matière
                    Text(
                      matiere,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const Divider(
                      color: Colors.lightBlue,
                      thickness: 1,
                      height: 20,
                    ),
                    // Liste des notes pour la matière
                    ...notes.map((note) {
                      IconData examIcon;
                      switch (note['type']) {
                        case "Contrôle continu":
                          examIcon = Icons.edit_note;
                          break;
                        case "Examen final":
                          examIcon = Icons.school;
                          break;
                        case "Devoir surveillé":
                          examIcon = Icons.assignment;
                          break;
                        default:
                          examIcon = Icons.note;
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.lightBlue.shade100,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  examIcon,
                                  color: Colors.lightBlue,
                                  size: 30,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note['type'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "Note : ${note['note']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
