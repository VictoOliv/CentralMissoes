import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/missao.dart';
import '../providers/missao_provider.dart';

class DetalhesPage extends StatelessWidget {
  final Missao missao;

  const DetalhesPage({super.key, required this.missao});

  Future<void> concluir(BuildContext context) async {
    await context.read<MissaoProvider>().concluir(missao);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Missão concluída!\nVocê conquistou ${missao.pontos} pontos.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const negrito = TextStyle(fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(title: const Text('DETALHES DA MISSÃO')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Título:', style: negrito),
            Text(missao.titulo),
            const SizedBox(height: 12),
            const Text('Dificuldade:', style: negrito),
            Text('${missao.estrelas} ${missao.dificuldade}'),
            const SizedBox(height: 12),
            const Text('Pontos:', style: negrito),
            Text('${missao.pontos}'),
            const SizedBox(height: 12),
            const Text('Status:', style: negrito),
            Text(missao.concluida ? 'Concluída' : 'Pendente'),
            const SizedBox(height: 12),
            const Text('Data:', style: negrito),
            Text(missao.data),
            const SizedBox(height: 24),
            if (!missao.concluida)
              ElevatedButton(
                onPressed: () => concluir(context),
                child: const Text('CONCLUIR MISSÃO'),
              ),
          ],
        ),
      ),
    );
  }
}
