import 'package:ovelhas/src/model/ovelhas_model.dart';
import '../repository/ovelha_repository.dart';

class OvelhaController {
  final _repository = OvelhaRepository();

  List<OvelhaModel> listar() => _repository.listar();

  Future<void> salvar(OvelhaModel ovelha) => _repository.salvar(ovelha);

  get listenable => _repository.listenable;
}
