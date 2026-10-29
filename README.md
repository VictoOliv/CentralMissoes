# Central de Missões

**Atividade 3 — somente a versão 1.**

Cadastro de missões com dificuldade, pontos, conclusão e exclusão no Cloud Firestore.

## Estrutura

- `versao1/`: projeto Flutter completo da versão publicada.

## Configurar Firebase

As configurações locais do projeto original não são publicadas. Copie
`firebase.local.example.json` para `firebase.local.json`, na raiz do repositório,
e preencha os valores da configuração Web do seu próprio projeto Firebase.

O arquivo `firebase.local.json` está no `.gitignore`. A aplicação recebe os valores
por `--dart-define-from-file`; não é necessário alterar o código Dart.
Habilite o Cloud Firestore e use as regras de exemplo em `firestore.rules` para
o ambiente educacional. A publicação deste código não aplica regras no Firebase.

Esta atividade não implementa login; as regras da aula permitem acesso público à coleção de missões e destinam-se a dados de demonstração.

Referência: [configuração oficial do Firebase para Flutter](https://firebase.google.com/docs/flutter/setup).

## Executar o Flutter

Instale o Flutter compatível com `versao1/pubspec.yaml` e execute:

```powershell
cd versao1
flutter pub get
flutter run -d chrome --dart-define-from-file=../firebase.local.json
```

## Verificação básica

```powershell
flutter analyze
flutter build web --dart-define-from-file=../firebase.local.json
```

O projeto foi conferido em Flutter Web em 28/10/2026, com análise e abertura básica.
Esta checagem não é uma bateria completa de testes. Builds nativos não foram validados.
