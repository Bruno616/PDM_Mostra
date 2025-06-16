import 'package:flutter/material.dart';
import 'tela_com_fundo.dart'; // Certifique-se de ter esse arquivo com o widget TelaComFundo
import 'package:jogos/TelaDet.dart';


class TelaEscolha extends StatelessWidget {
  final List<Map<String, String>> jogos = [
    {
      'titulo': 'A Quiet Place',
      'imagem': 'assets/placequiet.jpeg',
    },
    {
      'titulo': 'Wreck it Ralph',
      'imagem': 'assets/wreckit.jpeg',
    },
    {
      'titulo': 'Shrek the third',
      'imagem':'assets/shrek.jpeg',
    },
    {
      'titulo': 'Harry Potter',
      'imagem':'assets/hp.jpeg',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamescine'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: TelaComFundo(
        child: GridView.count(
          padding: EdgeInsets.all(12),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: jogos.map((jogo) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaDetalhes(jogo: jogo),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        jogo['imagem']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    jogo['titulo']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}