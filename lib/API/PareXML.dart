import 'package:school/API/classes.dart';
import 'package:school/API/httpreq.dart';
import 'package:xml/xml.dart';

/// Parses a list of `Emploi` objects from an XML response.
List<Emploi> parseEmploiList(String xmlResponse) {
  // Parse the XML string into a document
  final document = XmlDocument.parse(xmlResponse);

  // Extract all `<Table>` elements (case-sensitive)
  final tableElements = document.findAllElements('Table');

  // Map each `<Table>` element to an `Emploi` object
  return tableElements.map((node) => Emploi.fromXml(node)).toList();
}
List<Enseignant> parseEnseignant(String xmlResponse) {
  final document = XmlDocument.parse(xmlResponse);
  final tableElements = document.findAllElements('Table');
  return tableElements.map((node) => Enseignant.fromXml(node)).toList();
}
List<User> parseUser(String xmlResponse) {
  try {
    final document = XmlDocument.parse(xmlResponse);
    final tableElements = document.findAllElements('Table');
    return tableElements.map((node) =>User.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}
List<MatClasse> parseMatClasse(String xmlResponse) {
  try {
    final document = XmlDocument.parse(xmlResponse);
    final tableElements = document.findAllElements('Table');
    return tableElements.map((node) =>MatClasse.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}
List<Etudiant> parseEtudiant(String xmlResponse) {
  try {
    final document = XmlDocument.parse(xmlResponse);
    final tableElements = document.findAllElements('Table');
    return tableElements.map((node) =>Etudiant.fromXml(node)).toList();
  } catch (e) {
    print('Erreur lors de l\'analyse du XML: $e');
    return [];
  }
}