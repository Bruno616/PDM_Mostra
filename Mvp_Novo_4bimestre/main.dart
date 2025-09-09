import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const GamescineApp());
}

class GamescineApp extends StatelessWidget {
  const GamescineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gamescine",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const JogosPage(),
    );
  }
}

// -----------------------------
// Modelo do Jogo
// -----------------------------
class Jogo {
  final int id;
  final String nome;
  final String dataLancamento;
  final String produtora;
  final String genero;
  final List<String> plataformas;
  final String modo;
  final String sinopse;
  final List<String> imagens;
  final String link;
  final Map<String, String> redes;

  Jogo({
    required this.id,
    required this.nome,
    required this.dataLancamento,
    required this.produtora,
    required this.genero,
    required this.plataformas,
    required this.modo,
    required this.sinopse,
    required this.imagens,
    required this.link,
    required this.redes,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      id: json['id'],
      nome: json['nome'],
      dataLancamento: json['data_lancamento'],
      produtora: json['produtora'],
      genero: json['genero'],
      plataformas: List<String>.from(json['plataformas']),
      modo: json['modo'],
      sinopse: json['sinopse'],
      imagens: List<String>.from(json['imagens']),
      link: json['link'],
      redes: Map<String, String>.from(json['redes']),
    );
  }
}

// -----------------------------
// Página com lista de jogos
// -----------------------------
class JogosPage extends StatelessWidget {
  const JogosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(jsonJogos);
    final jogos = (data['app']['catalogo'] as List)
        .map((f) => Jogo.fromJson(f))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Gamescine")),
      body: ListView.builder(
        itemCount: jogos.length,
        itemBuilder: (context, index) {
          final jogo = jogos[index];
          return SizedBox(
            height: 160,
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Image.asset(
                  "assets/${jogo.imagens.first}", // primeira imagem do jogo
                  width: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  jogo.nome,
                  style: const TextStyle(fontSize: 35), // 🔹 agora igual aos filmes
                ),
                subtitle: Text(jogo.genero),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JogoDetalhesPage(jogo: jogo),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------
// Página de detalhes do jogo
// -----------------------------
class JogoDetalhesPage extends StatelessWidget {
  final Jogo jogo;
  const JogoDetalhesPage({super.key, required this.jogo});

  // Função para abrir links externos
  void _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(jogo.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data de Lançamento: ${jogo.dataLancamento}"),
            Text("Produtora: ${jogo.produtora}"),
            Text("Gênero: ${jogo.genero}"),
            Text("Modo: ${jogo.modo}"),
            const SizedBox(height: 10),

            Text("Plataformas:", style: const TextStyle(fontWeight: FontWeight.bold)),
            ...jogo.plataformas.map((p) => Text("- $p")),
            const SizedBox(height: 10),

            Text("Sinopse:", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(jogo.sinopse),
            const SizedBox(height: 20),

            // 🔹 Imagens em scroll horizontal
            Text("Imagens:", style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: jogo.imagens.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/${jogo.imagens[index]}",
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Botões de links oficiais
            Text("Links Oficiais:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _abrirLink(jogo.link),
              child: const Text("🌐 Site Oficial"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _abrirLink(jogo.redes['facebook']!),
              child: const Text("📘 Facebook"),
            ),
            ElevatedButton(
              onPressed: () => _abrirLink(jogo.redes['instagram']!),
              child: const Text("📸 Instagram"),
            ),
            ElevatedButton(
              onPressed: () => _abrirLink(jogo.redes['twitter']!),
              child: const Text("🐦 Twitter"),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------
// JSON de Jogos (sem "home")
// -----------------------------
const jsonJogos = '''
{
  "app": {
    "catalogo": [
      {
        "id": 1,
        "nome": "A Quiet Place: The Road Ahead",
        "data_lancamento": "17/10/2024",
        "produtora": "Interactive",
        "genero": "Survival horror",
        "plataformas": ["PC (Steam)", "PlayStation 5", "Xbox Series X/S"],
        "modo": "Single-player",
        "sinopse": "Em um mundo pós-apocalíptico dominado por criaturas sensíveis ao som, você assume o papel de Alex Taylor, uma jovem asmática que deve sobreviver em silêncio. Com mecânicas inovadoras que utilizam o microfone do jogador, qualquer ruído pode ser fatal.",
        "imagens": ["quiet.jpg","quiet1.jpg","quiet2.jpg","quiet3.jpg"],
        "link": "https://store.steampowered.com/app/2233120/A_Quiet_Place_The_Road_Ahead/",
        "redes": {
          "facebook": "https://www.facebook.com/share/1B3xXFu2uH/",
          "instagram": "https://www.instagram.com/aquietplace?igsh=MXNhdHh4dmk3YWkwMQ==",
          "twitter": "https://x.com/AQuietPlaceGame?t=FqFiFxmBE2nMhOhYOtFpFQ&s=09"
        }
      },
      {
        "id": 2,
        "nome": "Wreck-it Ralph",
        "data_lancamento": "30/10/2012",
        "produtora": "Pipeworks Software",
        "genero": "Ação / Plataforma",
        "plataformas": ["Nintendo Wii", "Nintendo DS", "Nintendo 3DS"],
        "modo": "Single-player",
        "sinopse": "Baseado no filme da Disney, o jogo segue Ralph e Felix em uma nova aventura para salvar o mundo dos jogos dos perigosos Cy-Bugs.",
        "imagens": ["ralph.jpg","ralph1.jpg","ralph2.jpg","ralph3.jpg"],
        "link": "https://www.imdb.com/title/tt1772341/",
        "redes": {
          "facebook": "https://www.facebook.com/Disney/?locale=pt_BR",
          "instagram": "https://www.instagram.com/disney/",
          "twitter": "https://x.com/Disney"
        }
      },
      {
        "id": 3,
        "nome": "Shrek the Third",
        "data_lancamento": "01/06/2007",
        "produtora": "Activision",
        "genero": "Aventura / Ação / Plataforma",
        "plataformas": ["PlayStation 2", "PC", "Wii", "PSP", "Nintendo DS", "Xbox 360"],
        "modo": "Single-player / Multiplayer",
        "sinopse": "Baseado no filme icônico, o jogo acompanha Shrek e seus amigos em uma jornada para encontrar o herdeiro do trono de tão tão distante.",
        "imagens": ["shrek.jpg","shrek1.jpg","shrek2.jpg","shrek3.jpg"],
        "link": "https://www.imdb.com/title/tt0413267/",
        "redes": {
          "facebook": "https://www.facebook.com/share/16sUZ8bK5d/",
          "instagram": "https://www.instagram.com/dreamworks?igsh=MXU2aGh1NWw0czhiNA==",
          "twitter": "https://x.com/Dreamworks?t=xNWQ4y1Ccl7nmUd6np1Acg&s=09"
        }
      },
      {
        "id": 4,
        "nome": "Harry Potter and the Deathly Hallows - Part 2",
        "data_lancamento": "12/07/2011",
        "produtora": "Electronic Arts",
        "genero": "Ação / Aventura",
        "plataformas": ["Xbox", "Wii", "PC", "PlayStation 3"],
        "modo": "Single-player",
        "sinopse": "Continua a batalha final contra Voldemort neste jogo que segue os eventos do último filme da saga Harry Potter.",
        "imagens": ["hp.jpg","hp1.jpg","hp2.jpg","hp3.jpg"],
        "link": "https://www.imdb.com/title/tt1201607/",
        "redes": {
          "facebook": "https://www.facebook.com/EA/",
          "instagram": "https://www.instagram.com/ea/",
          "twitter": "https://x.com/ea"
        }
      }
    ]
  }
}
''';
