import 'package:flutter/material.dart';
import 'package:ovelhas/src/view/listagem_view.dart';

class OvelhasApp extends StatelessWidget {
  const OvelhasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebanho de Ovelhas',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ListagemView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
