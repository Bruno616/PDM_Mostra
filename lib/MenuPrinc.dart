import 'package:flutter/material.dart';
import 'tela_com_fundo.dart';
import 'TelaEsc.dart'; // ou onde estiver sua tela

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
            ListTile(title: Text('Jogo'), onTap: () {}),
            ListTile(title: Text('Imagens'), onTap: () {}),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}