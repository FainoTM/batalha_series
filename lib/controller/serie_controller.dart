import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/serie_model.dart';


class SeriesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSerie(Serie serie) async {
    await _firestore.collection('series').add(serie.toMap());
  }

  Stream<List<Serie>> getSeries() {
    return _firestore.collection('series').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Serie.fromDocument(doc)).toList();
    });
  }

  Future<void> updatePontuacao(String id, int increment) async {
    await _firestore.collection('series').doc(id).update({
      'pontuacao': FieldValue.increment(increment),
    });
  }

  Future<List<Serie>> getSeriesOnce() async {
    try {
      final snapshot = await _firestore.collection('series').get();
      return snapshot.docs.map((doc) => Serie.fromDocument(doc)).toList();
    } catch (e) {
      print('Erro ao buscar séries: $e');
      throw Exception('Erro ao buscar séries.');
    }
  }


}
