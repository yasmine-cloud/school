import 'package:flutter/material.dart';
import 'package:school/Etudiant/home_etudiant.dart';

class AbsencesPage extends StatelessWidget {
  // Exemple de données d'absences
  final List<Map<String, String>> absences = [
    {
      "date": "2025-01-05",
      "cours": "Mathématiques",
      "nombre d\'absence ": "3",
    },
    {
      "date": "2025-01-02",
      "cours": "Histoire",
      "nombre d\'absence ": "2",
    },
    {
      "date": "2024-12-20",
      "cours": "Physique",
      "nombre d\'absence ": "1",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Mes Absences",
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
        child: ListView.builder(
          itemCount: absences.length,
          itemBuilder: (context, index) {
            final absence = absences[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cours
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          absence['cours']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Icon(Icons.book, color: Colors.blue, size: 24),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Date
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          "Date : ${absence['date']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // nombre d\'absence 
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          "nombre d\'absence  : ${absence['nombre d\'absence ']}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      
    );
  }
}
