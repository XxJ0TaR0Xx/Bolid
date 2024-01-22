import 'package:flutter/material.dart';

import 'package:bolid/core/services.dart';
import 'package:bolid/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const MainApp());
}
