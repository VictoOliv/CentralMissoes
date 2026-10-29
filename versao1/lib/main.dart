import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'providers/missao_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => MissaoProvider()..carregar(),
      child: const AppMissoes(),
    ),
  );
}

class AppMissoes extends StatelessWidget {
  const AppMissoes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Central de Missões',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const HomePage(),
    );
  }
}
