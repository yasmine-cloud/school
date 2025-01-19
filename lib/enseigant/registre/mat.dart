import 'package:flutter/material.dart';
import 'package:school/API/PareXML.dart';
import 'package:school/API/classes.dart';
import 'package:school/API/httpreq.dart';
import 'listetud.dart'; // Assurez-vous que ListEtudiants est bien importé

class MatPage extends StatefulWidget {
  const MatPage({super.key});

  @override
  State<MatPage> createState() => _MatPageState();
}

class _MatPageState extends State<MatPage> {
  int profId = 1; // ID du professeur, ici supposé être 1
  List<MatClasse> matieresProf = [];
  String? selectedMatiereLibelle;
  int? selectedMatiereId;
  int?selecetedSeanceID;
  List<MatClasse> selectedClasses = [];


  // Cette méthode récupère les matières d'un professeur
  Future<void> getMatieresProf() async {
    try {
      final queryParameters = {'Prof': profId.toString()}; // Utilisation de l'ID du professeur
      final response = await THttpHelper.get<MatClasse>(
        'GetMatProf', // L'endpoint de l'API
        parseMatClasse, // La fonction pour parser la réponse
        queryParameters: queryParameters,
      );
      setState(() {
        matieresProf = response; // Liste des matières du professeur
        selectedMatiereLibelle = null; // Réinitialise la matière sélectionnée
        selectedMatiereId = null;
        selectedClasses = []; // Réinitialise les classes sélectionnées

      });
    } catch (e) {
      print("Erreur lors de l'appel de l'API: $e");
    }
  }

  // Cette méthode filtre les classes selon la matière sélectionnée
  void getClassesForSelectedMatiere() {
    setState(() {
      selectedClasses = matieresProf
          .where((mat) => mat.Matiere == selectedMatiereId) // Filtre les classes par ID de matière
          .toList(); // Crée une liste des classes
    });
  }

  @override
  void initState() {
    super.initState();
    getMatieresProf(); // Récupère les matières du professeur dès l'initialisation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(
          child: Text(
            selectedMatiereLibelle == null
                ? 'Les Matières'
                : 'Classes pour ${selectedMatiereLibelle!}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: selectedMatiereLibelle == null
                ? ListView.builder(
                    itemCount: matieresProf.length,
                    itemBuilder: (context, index) {
                      final matiere = matieresProf[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedMatiereLibelle = matiere.libelle;
                                selectedMatiereId = matiere.Matiere; // Utilisation de l'ID de la matière
                                getClassesForSelectedMatiere();
                              });
                            },
                            child: ListTile(
                              leading: const Icon(Icons.book, color: Colors.lightBlueAccent),
                              title: Text(matiere.libelle), // Affiche le libelle de la matière
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.lightBlueAccent),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: selectedClasses.length,
                    itemBuilder: (context, index) {
                      final classe = selectedClasses[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListEtudiants(
                                    classeId: classe.Classe, // Passe l'ID de la classe
                                    matiereId: selectedMatiereId!, // Passe l'ID de la matière
                                    dateDebut: classe.DateDeb, // Passe la date de début
                                    dateFin: classe.DatFin, // Passe la date de fin
                                    seance:classe.Seance,
                                    seancenom: classe.seance1,



                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: const Icon(Icons.class_, color: Colors.lightBlueAccent),
                              title: Text(classe.libelle1), // Affiche le libelle1 de la classe
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.lightBlueAccent),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
} 

