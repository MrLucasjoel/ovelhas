import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ovelhas/src/controller/ovelha_controller.dart';
import 'package:ovelhas/src/model/ovelhas_model.dart';
import 'form_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListagemView extends StatefulWidget {
  const ListagemView({super.key});

  @override
  State<ListagemView> createState() => _ListagemViewState();
}

class _ListagemViewState extends State<ListagemView> {
  final controller = OvelhaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rebanho de Ovelhas')),
      body: ValueListenableBuilder(
        valueListenable: controller.listenable,
        builder: (context, Box<OvelhaModel> box, _) {
          final ovelhas = box.values.toList()
            ..sort((a, b) => a.rfidOvelha.compareTo(b.rfidOvelha));

          if (ovelhas.isEmpty) {
            return const Center(child: Text('Nenhuma ovelha cadastrada.'));
          }

          return ListView.builder(
            itemCount: ovelhas.length,
            itemBuilder: (context, index) {
              final o = ovelhas[index];
              return ListTile(
                title: Text('RFID: ${o.rfidOvelha}'),
                subtitle: Text(
                    'Raça: ${o.racaOvelha} | Idade: ${o.idadeOvelha} | Vacinada: ${o.indVacinada ? "Sim" : "Não"}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FormView(ovelha: o),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FormView()),
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text('Fechar Aplicativo'),
        ),
      ),
    );
  }
}
