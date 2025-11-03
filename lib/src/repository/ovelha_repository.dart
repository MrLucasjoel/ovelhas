import 'package:ovelhas/src/model/ovelhas_model.dart';
import 'package:ovelhas/src/datasource/hive_datasource.dart';

class OvelhaRepository {
  final _dataSource = OvelhaDataSource();

  List<OvelhaModel> listar() => _dataSource.listar();

  Future<void> salvar(OvelhaModel ovelha) => _dataSource.salvar(ovelha);

  get listenable => _dataSource.listenable();
}
