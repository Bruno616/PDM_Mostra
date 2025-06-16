import 'package:flutter/material.dart';
import 'TelaEsc.dart';           // TelaEscolha
import 'tela_com_fundo.dart';   // <- IMPORTANTE! O widget do fundo

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Gamescine')),
            ListTile(
              title: Text('Catálogo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TelaEscolha()),
                );
              },
            ),
            ListTile(
              title: Text('Jogo'),
              onTap: () {
                // implementar
              },
            ),
            ListTile(
              title: Text('Imagens'),
              onTap: () {
                // implementar
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Gamescine'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: TelaComFundo(
        child: Center(
          child: Text(
            'Bem-vindo ao Gamescine!',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Tira a faixa de debug
    home: MenuPrincipal(),
  ));
}