import 'package:flutter/material.dart';

class SaisieNotesGroupePage extends StatefulWidget {
  final String matiere;
  final String examen;
  final String classe;
  final List<String> eleves;

  const SaisieNotesGroupePage({
    super.key,
    required this.matiere,
    required this.examen,
    required this.classe,
    required this.eleves,
  });

  @override
  State<SaisieNotesGroupePage> createState() => _SaisieNotesGroupePageState();
}

class _SaisieNotesGroupePageState extends State<SaisieNotesGroupePage> {
  final Map<String, TextEditingController> _noteControllers = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var eleve in widget.eleves) {
      _noteControllers[eleve] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _noteControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveNotes() {
    if (_formKey.currentState!.validate()) {
      final notes = _noteControllers.map((eleve, controller) => MapEntry(eleve, controller.text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notes enregistrées pour ${widget.classe}'),
        ),
      );
      Navigator.pop(context, notes);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrigez les erreurs avant de sauvegarder.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saisie des Notes - ${widget.classe}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F9FF), Color(0xFFE8F0FE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Material(
  elevation: 8,
  borderRadius: BorderRadius.circular(12),
  shadowColor: Colors.black26,
  child: Container(
    
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.book, color: Colors.lightBlueAccent),
            const SizedBox(width: 8),
            Text(
              'Matière : ${widget.matiere}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.assignment, color: Colors.lightBlueAccent),
            const SizedBox(width: 8),
            Text(
              'Examen : ${widget.examen}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.school, color: Colors.lightBlueAccent),
            const SizedBox(width: 8),
            Text(
              'Classe : ${widget.classe}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    ),
  ),
),

            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  itemCount: widget.eleves.length,
                  itemBuilder: (context, index) {
                    final eleve = widget.eleves[index];
                    return Card(
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              foregroundColor: Colors.white,
                              radius: 20,
                              child: Icon(Icons.person, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                eleve,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: TextFormField(
                                controller: _noteControllers[eleve],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Note',
                                  labelStyle: const TextStyle(fontSize: 14),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Requis';
                                  }
                                  final note = double.tryParse(value);
                                  if (note == null) {
                                    return 'Invalide';
                                  }
                                  if (note < 0 || note > 20) {
                                    return '0-20';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _saveNotes,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    ' Enregistrer les notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
