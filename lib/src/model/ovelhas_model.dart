import 'package:hive/hive.dart';

/// Modelo simples de Ovelha + TypeAdapter manual (sem usar build_runner)
class OvelhaModel {
  final String rfidOvelha;
  final String racaOvelha;
  final int idadeOvelha;
  final bool indVacinada;

  OvelhaModel({
    required this.rfidOvelha,
    required this.racaOvelha,
    required this.idadeOvelha,
    required this.indVacinada,
  });

  OvelhaModel copyWith({
    String? rfidOvelha,
    String? racaOvelha,
    int? idadeOvelha,
    bool? indVacinada,
  }) {
    return OvelhaModel(
      rfidOvelha: rfidOvelha ?? this.rfidOvelha,
      racaOvelha: racaOvelha ?? this.racaOvelha,
      idadeOvelha: idadeOvelha ?? this.idadeOvelha,
      indVacinada: indVacinada ?? this.indVacinada,
    );
  }

  @override
  String toString() {
    return 'Ovelha(rfid: $rfidOvelha, raca: $racaOvelha, idade: $idadeOvelha, vacinada: $indVacinada)';
  }
}

/// Adapter manual para Hive — typeId = 0 (mantenha esse id consistente)
class OvelhaModelAdapter extends TypeAdapter<OvelhaModel> {
  @override
  final int typeId = 0;

  @override
  OvelhaModel read(BinaryReader reader) {
    // Lê na mesma ordem que foi escrito em write()
    final rfid = reader.readString();
    final raca = reader.readString();
    final idade = reader.readInt();
    final vac = reader.readBool();
    return OvelhaModel(
      rfidOvelha: rfid,
      racaOvelha: raca,
      idadeOvelha: idade,
      indVacinada: vac,
    );
  }

  @override
  void write(BinaryWriter writer, OvelhaModel obj) {
    // Escreve os campos em ordem estável
    writer.writeString(obj.rfidOvelha);
    writer.writeString(obj.racaOvelha);
    writer.writeInt(obj.idadeOvelha);
    writer.writeBool(obj.indVacinada);
  }

  // Opcional: igualdade por typeId
  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OvelhaModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
