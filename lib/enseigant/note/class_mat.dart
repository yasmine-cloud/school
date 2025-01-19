import 'package:flutter/material.dart';
import 'package:school/enseigant/note/note_eleve.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // Liste des matières, classes et types d'examens associés
  final List<Map<String, dynamic>> matieresEtClasses = [
    {
      'matiere': 'Mathématiques',
      'classes': [
        {
          'classe': 'Classe A',
          'eleves': ['Alice', 'Bob', 'Charlie'],
        },
        {
          'classe': 'Classe B',
          'eleves': ['David', 'Eve', 'Frank'],
        },
      ],
      'examens': ['Contrôle Continu', 'Examen Final'],
    },
    {
      'matiere': 'Histoire',
      'classes': [
        {
          'classe': 'Classe C',
          'eleves': ['Grace', 'Heidi', 'Ivan'],
        },
      ],
      'examens': ['Contrôle Continu', 'Examen Oral'],
    },
  ];

  String? selectedMatiere;
  String? selectedExamen;
  Map<String, dynamic>? selectedClasse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
        title: Center(
          child: Text(
            selectedMatiere == null
                ? 'Les Matières'
                : selectedExamen == null
                    ? 'Examens de $selectedMatiere'
                    : selectedClasse == null
                        ? 'Classes de $selectedMatiere'
                        : 'Élèves de ${selectedClasse!['classe']}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            setState(() {
              if (selectedClasse != null) {
                selectedClasse = null;
              } else if (selectedExamen != null) {
                selectedExamen = null;
              } else if (selectedMatiere != null) {
                selectedMatiere = null;
              } else {
                Navigator.pop(context);
              }
            });
          },
        ),
      ),
      body: selectedMatiere == null
          ? _buildMatiereList()
          : selectedExamen == null
              ? _buildExamenList()
              : selectedClasse == null
                  ? _buildClasseList()
                  : _buildEleveList(),
    );
  }

  Widget _buildMatiereList() {
    return ListView.builder(
      itemCount: matieresEtClasses.length,
      itemBuilder: (context, index) {
        final matiere = matieresEtClasses[index]['matiere'];
        return _buildCard(
          title: matiere,
          icon: Icons.book,
          onTap: () {
            setState(() {
              selectedMatiere = matiere;
            });
          },
        );
      },
    );
  }

  Widget _buildExamenList() {
    final examens = matieresEtClasses
        .firstWhere((element) => element['matiere'] == selectedMatiere)['examens']
        .cast<String>();

    return ListView.builder(
      itemCount: examens.length,
      itemBuilder: (context, index) {
        final examen = examens[index];
        return _buildCard(
          title: examen,
          icon: Icons.assignment,
          onTap: () {
            setState(() {
              selectedExamen = examen;
            });
          },
        );
      },
    );
  }

  Widget _buildClasseList() {
    final classes = matieresEtClasses
        .firstWhere((element) => element['matiere'] == selectedMatiere)['classes']
        .cast<Map<String, dynamic>>();

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classe = classes[index];
        return _buildCard(
          title: classe['classe'],
          icon: Icons.class_,
          onTap: () {
            setState(() {
              selectedClasse = classe;
            });
          },
        );
      },
    );
  }

Widget _buildEleveList() {
  final eleves = selectedClasse!['eleves'] as List<String>;

  return Center(
  
    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        // Image centrée
        Image.asset(
          'assets/note.png', // Remplacez par le chemin correct
          height: 450.0,
          width: 450.0,
          fit: BoxFit.contain,
        ),
       
        const SizedBox(height: 20.0),
        // Bouton central avec style simple
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaisieNotesGroupePage(
                  matiere: selectedMatiere!,
                  examen: selectedExamen!,
                  classe: selectedClasse!['classe'],
                  eleves: eleves,
                ),
              ),
            );
          },
           icon: const Icon(Icons.edit_note, size: 24.0,color: Colors.white,), // Icône ajoutée
          label: const Text(
                'Saisir les notes pour tous les élèves',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
              ),
        ),
      ],
    ),
  );
}




  Widget _buildCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0),
          splashColor: Colors.lightBlueAccent.withOpacity(0.2),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            leading: Icon(icon, color: Colors.lightBlueAccent, size: 28),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.lightBlueAccent),
          ),
        ),
      ),
    );
  }
}

