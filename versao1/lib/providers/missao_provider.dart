import 'package:flutter/material.dart';

import '../models/missao.dart';
import '../services/missao_service.dart';

class MissaoProvider extends ChangeNotifier {
  final service = MissaoService();
  List<Missao> missoes = [];
  bool carregando = false;

  int get pontuacaoTotal {
    int total = 0;
    for (final missao in missoes) {
      if (missao.concluida) total += missao.pontos;
    }
    return total;
  }

  int pontosDaDificuldade(String dificuldade) {
    if (dificuldade == 'Difícil') return 30;
    if (dificuldade == 'Médio') return 20;
    return 10;
  }

  String dataDeHoje() {
    final hoje = DateTime.now();
    final dia = hoje.day.toString().padLeft(2, '0');
    final mes = hoje.month.toString().padLeft(2, '0');
    return '$dia/$mes/${hoje.year}';
  }

  Future<void> carregar() async {
    carregando = true;
    notifyListeners();
    missoes = await service.buscarTodas();
    carregando = false;
    notifyListeners();
  }

  Future<void> cadastrar(String titulo, String dificuldade) async {
    final missao = Missao(
      titulo: titulo,
      dificuldade: dificuldade,
      pontos: pontosDaDificuldade(dificuldade),
      data: dataDeHoje(),
    );
    await service.adicionar(missao);
    await carregar();
  }

  Future<void> concluir(Missao missao) async {
    missao.concluida = true;
    await service.atualizar(missao);
    await carregar();
  }

  Future<void> excluir(Missao missao) async {
    await service.excluir(missao.id!);
    await carregar();
  }
}
