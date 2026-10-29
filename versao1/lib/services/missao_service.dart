import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/missao.dart';

class MissaoService {
  final colecao = FirebaseFirestore.instance.collection('missoes');

  Future<void> adicionar(Missao missao) async {
    await colecao.add(missao.toMap());
  }

  Future<List<Missao>> buscarTodas() async {
    final resultado = await colecao.get();
    return resultado.docs.map((doc) => Missao.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> atualizar(Missao missao) async {
    await colecao.doc(missao.id).update(missao.toMap());
  }

  Future<void> excluir(String id) async {
    await colecao.doc(id).delete();
  }
}
