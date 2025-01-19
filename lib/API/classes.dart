import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'dart:convert';

// Méthodes utilitaires pour extraire des valeurs sûres à partir de XML
//Trouver la valeur texte associée à un tag XML spécifique.
String findText(XmlElement node, String tagName, {String defaultValue = ''}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty ? elements.single.text : defaultValue;
}

int findInt(XmlElement node, String tagName, {int defaultValue = 0}) {
  final elements = node.findElements(tagName);
  return elements.isNotEmpty
      ? int.tryParse(elements.single.text) ?? defaultValue
      : defaultValue;
}

DateTime findDate(XmlElement node, String tagName, {DateTime? defaultValue}) {
  final elements = node.findElements(tagName);
  if (elements.isNotEmpty) {
    try {
      return DateTime.parse(elements.single.text);
    } catch (_) {
      return defaultValue ?? DateTime(1970, 1, 1);
    }
  }
  return defaultValue ?? DateTime(1970, 1, 1);
}

class Emploi {
  final String classe;
  final String Matiere;
  final String hrdeb;
  final String hrfin;
  final String Prof;
  final String salle;
  String? Jour1;
  final int jour;
  Emploi(
      {required this.Matiere,
      required this.Prof,
      required this.classe,
      required this.hrdeb,
      required this.hrfin,
      required this.jour,
      required this.salle,
      this.Jour1});
//Objectif : Créer une instance d'Emploi à partir d'un élément XML.
//Utilise les méthodes utilitaires pour extraire les valeurs de chaque tag.
  factory Emploi.fromXml(XmlElement node) {
    print('Parsing XML: $node'); // Affiche le nœud XML avant de le parser

    return Emploi(
        Matiere: findText(node, 'Matiere'),
        Prof: findText(node, 'Prof'),
        classe: findText(node, 'classe'),
        hrdeb: findText(node, 'hrdeb'),
        hrfin: findText(node, 'hrfin'),
        jour: findInt(node, 'jour'),
        salle: findText(node, 'salle'),
        Jour1: findText(node, 'Jour1'));
  }
//Objectif : Convertir une instance d'Emploi en une chaîne XML.
//Utilise XmlBuilder pour construire dynamiquement la structure XML.
//Inclut tous les champs de l'objet dans des balises correspondantes.
  String toXml() {
    final builder = XmlBuilder();
    builder.element('table', nest: () {
      builder.element('Matiere', nest: Matiere);
      builder.element('Prof', nest: Prof);
      builder.element('classe', nest: classe);
      builder.element('hrdeb', nest: hrdeb);
      builder.element('hrfin', nest: hrfin);
      builder.element('salle', nest: salle);
      builder.element('Jour1', nest: Jour1);
      builder.element('jour', nest: jour?.toString() ?? '');
    });
    return builder.buildDocument().toXmlString();
  }
}

class Enseignant {
  final int Code;
  final String Photo;
  final int Departement;
  final String Matcle;
  final String Nom;
  final String Prenom;
  final String NomPat;
  final String NumCIN;
  final DateTime DatNai;
  final String LieuNai;
  final int Sexe;
  final int Qualite;
  final int SitFam;
  final String Nation;
  final String Adresse;
  final int Gouvernorat;
  final int Pays;
  final String Tel;
  final String Email;
  final String NumPas;
  final String IdUnique;
  final int Grade;
  final DateTime DatGrade;
  final DateTime DatAn;
  final int Statut;
  final String libgrade;
  final String libDepartement;

  Enseignant({
    required this.Code,
    required this.Photo,
    required this.Departement,
    required this.Matcle,
    required this.Nom,
    required this.Prenom,
    required this.NomPat,
    required this.NumCIN,
    required this.DatNai,
    required this.LieuNai,
    required this.Sexe,
    required this.Qualite,
    required this.SitFam,
    required this.Nation,
    required this.Adresse,
    required this.Gouvernorat,
    required this.Pays,
    required this.Tel,
    required this.Email,
    required this.NumPas,
    required this.IdUnique,
    required this.Grade,
    required this.DatGrade,
    required this.DatAn,
    required this.Statut,
    required this.libgrade,
    required this.libDepartement,
  });

  factory Enseignant.fromXml(XmlElement node) {
    return Enseignant(
      Code: findInt(node, 'Code'),
      Photo: findText(node, 'Photo'),
      Departement: findInt(node, 'Departement'),
      Matcle: findText(node, 'Matcle'),
      Nom: findText(node, 'Nom'),
      Prenom: findText(node, 'Prenom'),
      NomPat: findText(node, 'NomPat'),
      NumCIN: findText(node, 'NumCIN'),
      DatNai: findDate(node, 'DatNai'),
      LieuNai: findText(node, 'LieuNai'),
      Sexe: findInt(node, 'Sexe'),
      Qualite: findInt(node, 'Qualite'),
      SitFam: findInt(node, 'SitFam'),
      Nation: findText(node, 'Nation'),
      Adresse: findText(node, 'Adresse'),
      Gouvernorat: findInt(node, 'Gouvernorat'),
      Pays: findInt(node, 'Pays'),
      Tel: findText(node, 'Tel'),
      Email: findText(node, 'Email'),
      NumPas: findText(node, 'NumPas'),
      IdUnique: findText(node, 'IdUnique'),
      Grade: findInt(node, 'Grade'),
      DatGrade: findDate(node, 'DatGrade'),
      DatAn: findDate(node, 'DatAn'),
      Statut: findInt(node, 'Statut'),
      libgrade: findText(node, 'libgrade'),
      libDepartement: findText(node, 'libDepartement'),
    );
  }
}

class User {
  final String Login;
  final String Pass;
  final int Profil;
  final int Prof;
  final int Etd;
  final String Nom;
  final int Nature;
  final int Dep;

  User({
    required this.Pass,
    required this.Login,
    required this.Profil,
    required this.Prof,
    required this.Etd,
    required this.Nom,
    required this.Nature,
    required this.Dep,
  });
  factory User.fromXml(XmlElement node) {
    return User(
      Pass: findText(node, 'Pass'),
      Login: findText(node, 'numcin'),
      Profil: findInt(node, 'Profil'),
      Prof: findInt(node, 'Prof'),
      Etd: findInt(node, 'Prof'),
      Nom: findText(node, 'Nom'),
      Nature: findInt(node, 'Nature'),
      Dep: findInt(node, 'Dep'),
    );
  }
}

class MatClasse {
  final int id;
  final int Prof;
  final int Matiere;
  final int Scolaire;
  final int Classe;
  final DateTime DateDeb;
  final DateTime DatFin;
  final String libelle;
  final String libelle1;
  final int Seance;
  final String seance1;


  MatClasse({
    required this.Seance,
    required this.seance1, 
    required this.Scolaire,
    required this.Classe,
    required this.DateDeb,
    required this.DatFin,
    required this.libelle,
    required this.libelle1,
    required this.id,
    required this.Prof,
    required this.Matiere,
  });
    factory MatClasse.fromXml(XmlElement node) {
    return MatClasse(
      id:  findInt(node, 'Id'),
      Prof:  findInt(node, 'Prof'),
      Matiere:  findInt(node, 'Matiere'),
      Scolaire:  findInt(node, 'Scolaire'),
      Classe: findInt(node, 'Classe'),
      DateDeb:  findDate(node, 'DatDeb'),
      DatFin:  findDate(node, 'DatFin'),
      libelle:findText(node, 'libelle'),
      libelle1: findText(node, 'libelle1'), 
      Seance: findInt(node, 'Seance'),
      seance1: findText(node, 'seance1'),


    );
  }

}
class Etudiant{
  final int code;
  final String etudiant;
  Etudiant({
    required this.code,
    required this.etudiant,
  });
  factory Etudiant.fromXml(XmlElement node){
    return Etudiant(
      code: findInt(node, 'code'),
     etudiant: findText(node, 'etudiant'),
     );
  }
}