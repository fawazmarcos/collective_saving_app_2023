// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DemandeRetraitModel {
  String id;
  String montant;
  String idSouscription;
  String telephone;
  Timestamp? date;
  String createdAt;
  String idUtilisateur;
  int traitement; //Vaut 0 si non traité, 1 si traité
  DemandeRetraitModel({
    required this.id,
    required this.montant,
    required this.idSouscription,
    required this.telephone,
    this.date,
    required this.createdAt,
    required this.idUtilisateur,
    required this.traitement,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'montant': montant,
      'idSouscription': idSouscription,
      'telephone': telephone,
      'date': date,
      'createdAt': createdAt,
      'idUtilisateur': idUtilisateur,
      'traitement': traitement,
    };
  }

  factory DemandeRetraitModel.fromMap(DocumentSnapshot document) {
    var data = document.data() as Map;
    Map map = data;
    return DemandeRetraitModel(
      id: map['id'] as String,
      montant: map['montant'] as String,
      idSouscription: map['idSouscription'] as String,
      telephone: map['telephone'] as String,
      date: map['date'] != null ? map['date'] : null,
      createdAt: map['createdAt'] as String,
      idUtilisateur: map['idUtilisateur'] as String,
      traitement: map['traitement'] as int,
    );
  }
}
