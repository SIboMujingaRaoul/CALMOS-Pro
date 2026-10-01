import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CalmosApp());
}

class CalmosApp extends StatelessWidget {
  const CalmosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CALMOS PRO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  final List<String> titles = [
    'Accueil',
    'Professeur IA',
    'Scanner',
    'Progression',
    'Compte',
  ];

  String serverStatus = 'Connexion au serveur...';
  bool serverOnline = false;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  Future<void> connectToServer() async {
    if (mounted) {
      setState(() {
        serverStatus = 'Connexion au serveur...';
      });
    }

    try {
      final response = await http
          .get(
            Uri.parse('https://calmos-pro.onrender.com/'),
          )
          .timeout(const Duration(seconds: 30));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);

        setState(() {
          serverOnline = true;

          if (data is Map<String, dynamic>) {
            serverStatus =
                data['message']?.toString() ??
                'Serveur CALMOS PRO connecté';
          } else {
            serverStatus = 'Serveur CALMOS PRO connecté';
          }
        });
      } else {
        setState(() {
          serverOnline = false;
          serverStatus =
              'Erreur serveur : ${response.statusCode}';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        serverOnline = false;
        serverStatus = 'Connexion impossible';
      });
    }
  }

  void go(int index) {
    setState(() {
      page = index;
    });

    Navigator.pop(context);
  }

  Widget buildCurrentPage() {
    switch (page) {
      case 1:
        return const Center(
          child: Text(
            'Professeur IA\nBientôt disponible',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        );

      case 2:
        return const Center(
          child: Text(
            'Scanner de devoirs\nBientôt disponible',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        );

      case 3:
        return const Center(
          child: Text(
            'Progression de l’élève\nBientôt disponible',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        );

      case 4:
        return const Center(
          child: Text(
            'Compte utilisateur\nBientôt disponible',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        );

      default:
        return buildHomePage();
    }
  }

  Widget buildHomePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'CALMOS PRO',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Votre professeur intelligent',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 35),

            Icon(
              serverOnline
                  ? Icons.cloud_done
                  : Icons.cloud_off,
              size: 42,
              color: serverOnline
                  ? Colors.green
                  : Colors.orange,
            ),

            const SizedBox(height: 10),

            Text(
              serverStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: connectToServer,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Tester la connexion',
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Apprendre • Comprendre • Progresser',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALMOS PRO - ${titles[page]}',
        ),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const ListTile(
                leading: Icon(Icons.school),
                title: Text(
                  'CALMOS PRO',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Professeur intelligent',
                ),
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Accueil'),
                onTap: () => go(0),
              ),

              ListTile(
                leading: const Icon(Icons.smart_toy),
                title: const Text('Professeur IA'),
                onTap: () => go(1),
              ),

              ListTile(
                leading: const Icon(
                  Icons.document_scanner,
                ),
                title: const Text('Scanner'),
                onTap: () => go(2),
              ),

              ListTile(
                leading: const Icon(Icons.trending_up),
                title: const Text('Progression'),
                onTap: () => go(3),
              ),

              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Compte'),
                onTap: () => go(4),
              ),
            ],
          ),
        ),
      ),

      body: buildCurrentPage(),
    );
  }
}
