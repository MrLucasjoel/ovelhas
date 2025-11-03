import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ovelhas/src/model/ovelhas_model.dart';

class OvelhaDataSource {
  final Box<OvelhaModel> _box = Hive.box<OvelhaModel>('ovelhasBox');

  List<OvelhaModel> listar() {
    final lista = _box.values.toList();
    lista.sort((a, b) => a.rfidOvelha.compareTo(b.rfidOvelha));
    return lista;
  }

  Future<void> salvar(OvelhaModel ovelha) async {
    await _box.put(ovelha.rfidOvelha, ovelha);
  }

  ValueListenable<Box<OvelhaModel>> listenable() {
    return _box.listenable();
  }
}
