import 'package:flutter/material.dart';
import 'package:jogos/TelaImg.dart';
import 'tela_com_fundo.dart'; // Importa o fundo amarelo

class TelaDetalhes extends StatelessWidget {
  final Map<String, String> jogo;

  TelaDetalhes({required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamescine'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: TelaComFundo(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(jogo['imagem']!, height: 200)),
              SizedBox(height: 16),
              Text(
                'A Quiet Place: The Road Ahead',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Data de lançamento: 17/10/2024'),
              Text('Produtora: Saber Interactive'),
              Text('Gênero: Survival Horror'),
              Text('Plataformas: PC, PS5, Xbox'),
              Text('Modo: Single player'),
              SizedBox(height: 12),
              Text(
                'Sinopse:\nEm um mundo pós-apocalíptico dominado por criaturas sensíveis ao som...',
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TelaImagens()),
                    );
                  },
                  child: Text('Ver Imagens'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}