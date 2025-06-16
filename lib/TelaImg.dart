import 'package:flutter/material.dart';
import 'tela_com_fundo.dart';  // Certifique-se de importar o widget do fundo

class TelaImagens extends StatelessWidget {
  final List<String> imagens = [
    'assets/quiet1.jpg',
    'assets/quiet2.jpg',
    'assets/quiet3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagens'),
        backgroundColor: Colors.orange.shade700,  // Cor do appBar
      ),
      body: TelaComFundo(
        child: ListView(
          children: imagens.map((img) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(img),
            );
          }).toList(),
        ),
      ),
    );
  }
}