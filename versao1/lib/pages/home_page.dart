import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/missao.dart';
import '../providers/missao_provider.dart';
import 'detalhes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controleTitulo = TextEditingController();
  String dificuldade = 'Fácil';

  @override
  void dispose() {
    controleTitulo.dispose();
    super.dispose();
  }

  Future<void> cadastrar() async {
    final titulo = controleTitulo.text.trim();
    if (titulo.isEmpty) return;
    await context.read<MissaoProvider>().cadastrar(titulo, dificuldade);
    controleTitulo.clear();
  }

  Future<void> concluir(Missao missao) async {
    await context.read<MissaoProvider>().concluir(missao);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Missão concluída!\nVocê conquistou ${missao.pontos} pontos.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MissaoProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('CENTRAL DE MISSÕES')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'PONTOS CONQUISTADOS: ${provider.pontuacaoTotal}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controleTitulo,
              decoration: const InputDecoration(labelText: 'Título da missão'),
            ),
            DropdownButtonFormField<String>(
              initialValue: dificuldade,
              decoration: const InputDecoration(labelText: 'Dificuldade'),
              items: const [
                DropdownMenuItem(value: 'Fácil', child: Text('Fácil')),
                DropdownMenuItem(value: 'Médio', child: Text('Médio')),
                DropdownMenuItem(value: 'Difícil', child: Text('Difícil')),
              ],
              onChanged: (valor) => setState(() => dificuldade = valor!),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: cadastrar, child: const Text('CADASTRAR MISSÃO')),
            const Divider(height: 32),
            Expanded(
              child: provider.carregando && provider.missoes.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: provider.missoes.length,
                      separatorBuilder: (context, indice) => const Divider(),
                      itemBuilder: (context, indice) {
                        final missao = provider.missoes[indice];
                        return ListTile(
                          title: Text(missao.titulo),
                          subtitle: Text(
                            'Dificuldade: ${missao.estrelas}\n'
                            'Pontos: ${missao.pontos}\n'
                            'Status: ${missao.concluida ? 'Concluída' : 'Pendente'}\n'
                            'Data: ${missao.data}',
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetalhesPage(missao: missao)),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!missao.concluida)
                                TextButton(
                                  onPressed: () => concluir(missao),
                                  child: const Text('CONCLUIR'),
                                ),
                              TextButton(
                                onPressed: () => provider.excluir(missao),
                                child: const Text('EXCLUIR'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
