import 'package:flutter/material.dart';

void main() => runApp(const CalmosApp());

class CalmosApp extends StatelessWidget {
  const CalmosApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CALMOS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
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
  final titles = ['Accueil','Professeur IA','Scanner','J’ai été absent','Exercices','Progression','Premium'];
  void go(int i) => setState(() => page=i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CALMOS — ${titles[page]}')),
      drawer: Drawer(child: SafeArea(child: ListView(children: [
        const ListTile(title: Text('CALMOS', style: TextStyle(fontSize:28,fontWeight:FontWeight.bold))),
        ...List.generate(titles.length, (i)=>ListTile(
          leading: Icon([Icons.home,Icons.smart_toy,Icons.camera_alt,Icons.menu_book,Icons.edit_note,Icons.insights,Icons.workspace_premium][i]),
          title: Text(titles[i]), selected: page==i,
          onTap:(){Navigator.pop(context);go(i);}
        ))
      ]))),
      body: IndexedStack(index: page, children: [
        Dashboard(go:go), const TutorPage(), const ScannerPage(), const AbsencePage(),
        const PracticePage(), const ProgressPage(), const PremiumPage()
      ]),
    );
  }
}

class Dashboard extends StatelessWidget {
  final void Function(int) go;
  const Dashboard({super.key, required this.go});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children:[
    Card(color:Theme.of(context).colorScheme.primaryContainer, child:Padding(
      padding:const EdgeInsets.all(22), child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        const Text('Bonjour 👋',style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
        const SizedBox(height:8), const Text('Que veux-tu apprendre aujourd’hui ?'),
        const SizedBox(height:16), FilledButton(onPressed:()=>go(1),child:const Text('Commencer avec CALMOS'))
      ]))),
    const SizedBox(height:14),
    GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:2,
      childAspectRatio:1.25,mainAxisSpacing:10,crossAxisSpacing:10,children:[
        ActionCard('📷','Scanner un exercice',()=>go(2)),
        ActionCard('🧠','Professeur IA',()=>go(1)),
        ActionCard('📚','J’ai été absent',()=>go(3)),
        ActionCard('🎯','Réviser',()=>go(4)),
      ]),
    const SizedBox(height:16),
    const Text('Matières',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
    const Wrap(spacing:8,runSpacing:8,children:[
      Chip(label:Text('➗ Mathématiques')),Chip(label:Text('📐 Trigonométrie')),
      Chip(label:Text('⚗️ Chimie')),Chip(label:Text('🔬 Sciences'))
    ]),
    const SizedBox(height:16),
    const Text('Langues : Français · English · Español · Português · العربية · Hausa · Bambara')
  ]);
}

class ActionCard extends StatelessWidget {
  final String emoji,title; final VoidCallback tap;
  const ActionCard(this.emoji,this.title,this.tap,{super.key});
  @override Widget build(BuildContext context)=>Card(child:InkWell(onTap:tap,borderRadius:BorderRadius.circular(12),
    child:Padding(padding:const EdgeInsets.all(14),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
      Text(emoji,style:const TextStyle(fontSize:32)),const SizedBox(height:8),Text(title,textAlign:TextAlign.center,style:const TextStyle(fontWeight:FontWeight.bold))
    ]))));
}

class TutorPage extends StatefulWidget { const TutorPage({super.key}); @override State<TutorPage> createState()=>_TutorPageState(); }
class _TutorPageState extends State<TutorPage>{
  final c=TextEditingController(); String answer='Bonjour ! Donne-moi un exercice. Je t’expliquerai la méthode étape par étape.';
  void send(){final q=c.text.trim(); if(q.isEmpty)return; setState(() {
    answer=q.replaceAll(' ','').contains('2x+7=15')
      ? 'Étape 1 : 2x + 7 = 15\nÉtape 2 : soustraire 7 → 2x = 8\nÉtape 3 : diviser par 2 → x = 4\nVérification : 2 × 4 + 7 = 15 ✅'
      : 'Prototype V1 : le moteur IA sécurisé sera connecté au backend CALMOS. La prochaine version produira ici une explication personnalisée et vérifiée.';
  });}
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.all(18),child:Column(children:[
    Expanded(child:ListView(children:[Card(child:Padding(padding:const EdgeInsets.all(16),child:Text(answer)))])),
    Row(children:[Expanded(child:TextField(controller:c,decoration:const InputDecoration(border:OutlineInputBorder(),hintText:'Ex. Résous 2x + 7 = 15'))),
      const SizedBox(width:8),FilledButton(onPressed:send,child:const Icon(Icons.send))])
  ]));
}

class ScannerPage extends StatelessWidget { const ScannerPage({super.key});
  @override Widget build(BuildContext context)=>Center(child:Padding(padding:const EdgeInsets.all(24),child:Card(child:Padding(
    padding:const EdgeInsets.all(30),child:Column(mainAxisSize:MainAxisSize.min,children:[
      const Icon(Icons.camera_alt,size:70),const Text('Scanner un exercice',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
      const SizedBox(height:10),const Text('La caméra/OCR réelle sera reliée dans la version connectée.',textAlign:TextAlign.center),
      const SizedBox(height:18),FilledButton(onPressed:(){showDialog(context:context,builder:(_)=>const AlertDialog(title:Text('Démonstration'),content:Text('Énoncé reconnu : 2x + 7 = 15\\nRésultat : x = 4')));},child:const Text('Simuler une analyse'))
    ])))));}

class AbsencePage extends StatefulWidget { const AbsencePage({super.key}); @override State<AbsencePage> createState()=>_AbsencePageState(); }
class _AbsencePageState extends State<AbsencePage>{
  String country='France'; String subject='Mathématiques'; bool generated=false;
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    const Text('Rattraper un cours manqué',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
    DropdownButtonFormField(value:country,items:['France','USA','Angleterre','Allemagne','Afrique du Sud','Chine','Maroc','Espagne','Suède','Belgique','Canada'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>country=v!)),
    const SizedBox(height:10),
    DropdownButtonFormField(value:subject,items:['Mathématiques','Trigonométrie','Chimie','Sciences'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>subject=v!)),
    const SizedBox(height:14),FilledButton(onPressed:()=>setState(()=>generated=true),child:const Text('Générer le cours')),
    if(generated) Card(child:Padding(padding:const EdgeInsets.all(16),child:Text('Programme : $country\\nMatière : $subject\\n\\n1. Objectifs\\n2. Explication progressive\\n3. Exemples guidés\\n4. Exercices\\n5. Correction\\n6. Test final\\n\\nLe moteur Global Curriculum sera connecté à des référentiels scolaires versionnés.')))
  ]);
}

class PracticePage extends StatelessWidget { const PracticePage({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    const Text('Exercices personnalisés',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
    ...['Fractions — 90 %','Équations — 72 %','Trigonométrie — 38 %'].map((x)=>Card(child:ListTile(title:Text(x),trailing:const Icon(Icons.play_arrow))))
  ]);}

class ProgressPage extends StatelessWidget { const ProgressPage({super.key});
  @override Widget build(BuildContext context)=>GridView.count(padding:const EdgeInsets.all(18),crossAxisCount:2,children:const[
    Card(child:Center(child:Text('📚\\n14 leçons',textAlign:TextAlign.center))),Card(child:Center(child:Text('🎯\\n86 exercices',textAlign:TextAlign.center))),
    Card(child:Center(child:Text('🔥\\n7 jours',textAlign:TextAlign.center))),Card(child:Center(child:Text('⭐\\n1 240 points',textAlign:TextAlign.center)))
  ]);}

class PremiumPage extends StatefulWidget { const PremiumPage({super.key}); @override State<PremiumPage> createState()=>_PremiumPageState(); }
class _PremiumPageState extends State<PremiumPage>{
  String method='ILLICOCASH';
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    const Text('CALMOS Premium',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold)),
    const Text('Choisis une formule puis un moyen de paiement.'),
    const Card(child:ListTile(title:Text('Hebdomadaire'),subtitle:Text('Prix à configurer'))),
    const Card(child:ListTile(title:Text('Mensuel'),subtitle:Text('Prix à configurer'))),
    const Card(child:ListTile(title:Text('Annuel'),subtitle:Text('Prix à configurer'))),
    const SizedBox(height:12),
    DropdownButtonFormField(value:method,items:['ILLICOCASH','M-Pesa','Orange Money','RAWBANK','Visa / Mastercard'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>method=v!)),
    const SizedBox(height:12),
    if(method=='ILLICOCASH'||method=='M-Pesa') const Card(child:ListTile(leading:Icon(Icons.phone_android),title:Text('Numéro de paiement configuré'),subtitle:Text('Les coordonnées réelles doivent être protégées et confirmées côté serveur.'))),
    FilledButton(onPressed:(){showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Paiement'),content:Text('Prototype : $method sera connecté à son canal officiel et vérifié côté serveur.')));},child:const Text('Continuer'))
  ]);}
