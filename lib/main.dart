import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ovelhas/src/app/app_widget.dart';
import 'package:ovelhas/src/model/ovelhas_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(OvelhaModelAdapter());
  await Hive.openBox<OvelhaModel>('ovelhasBox');

  runApp(const OvelhasApp());
}