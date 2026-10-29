class Missao {
  String? id;
  String titulo;
  String dificuldade;
  int pontos;
  bool concluida;
  String data;

  Missao({
    this.id,
    required this.titulo,
    required this.dificuldade,
    required this.pontos,
    this.concluida = false,
    required this.data,
  });

  String get estrelas {
    if (dificuldade == 'Difícil') return '⭐⭐⭐';
    if (dificuldade == 'Médio') return '⭐⭐';
    return '⭐';
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'dificuldade': dificuldade,
      'pontos': pontos,
      'concluida': concluida,
      'data': data,
    };
  }

  factory Missao.fromMap(String id, Map<String, dynamic> mapa) {
    return Missao(
      id: id,
      titulo: mapa['titulo'] ?? '',
      dificuldade: mapa['dificuldade'] ?? 'Fácil',
      pontos: mapa['pontos'] ?? 0,
      concluida: mapa['concluida'] ?? false,
      data: mapa['data'] ?? '',
    );
  }
}
