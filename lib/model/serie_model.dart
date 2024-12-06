import 'package:cloud_firestore/cloud_firestore.dart';

class Serie {
  String id;
  String nome;
  String genero;
  String descricao;
  String capa;
  int pontuacao;

  Serie({
    required this.id,
    required this.nome,
    required this.genero,
    required this.descricao,
    required this.capa,
    this.pontuacao = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'genero': genero,
      'descricao': descricao,
      'capa': capa,
      'pontuacao': pontuacao,
    };
  }

  factory Serie.fromDocument(DocumentSnapshot doc) {
    return Serie(
      id: doc.id,
      nome: doc['nome'],
      genero: doc['genero'],
      descricao: doc['descricao'],
      capa: doc['capa'],
      pontuacao: doc['pontuacao'],
    );
  }
}
