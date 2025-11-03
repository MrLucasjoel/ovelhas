import 'package:flutter/material.dart';
import 'package:ovelhas/src/controller/ovelha_controller.dart';
import 'package:ovelhas/src/model/ovelhas_model.dart';
import 'package:ovelhas/src/widget/input_rfid_formatter.dart';

class FormView extends StatefulWidget {
  final OvelhaModel? ovelha;
  const FormView({super.key, this.ovelha});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = OvelhaController();
  final _rfidController = TextEditingController();
  final _idadeController = TextEditingController();
  bool _vacinada = false;
  String? _racaSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.ovelha != null) {
      _rfidController.text = widget.ovelha!.rfidOvelha;
      _idadeController.text = widget.ovelha!.idadeOvelha.toString();
      _racaSelecionada = widget.ovelha!.racaOvelha;
      _vacinada = widget.ovelha!.indVacinada;
    }
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final nova = OvelhaModel(
        rfidOvelha: _rfidController.text,
        racaOvelha: _racaSelecionada!,
        idadeOvelha: int.parse(_idadeController.text),
        indVacinada: _vacinada,
      );
      _controller.salvar(nova).then((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.ovelha == null
              ? 'Adicionar Ovelha'
              : 'Editar Ovelha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _rfidController,
                inputFormatters: [RfidInputFormatter()],
                decoration: const InputDecoration(labelText: 'RFID'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o RFID';
                  if (!RegExp(r'^\d{3}-\d{15}$').hasMatch(v)) {
                    return 'Formato inválido (999-000000000000)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Raça'),
              ...['Santa Inês', 'Dorper', 'Texel'].map((raca) {
                return CheckboxListTile(
                  title: Text(raca),
                  value: _racaSelecionada == raca,
                  onChanged: (v) {
                    setState(() {
                      _racaSelecionada = v! ? raca : null;
                    });
                  },
                );
              }),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Idade (anos)'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a idade';
                  final idade = int.tryParse(v);
                  if (idade == null || idade < 0) return 'Idade inválida';
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Vacinada'),
                value: _vacinada,
                onChanged: (v) => setState(() => _vacinada = v),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
