import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theme_setup/src/app.dart';
import 'package:theme_setup/src/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive
  await Hive.initFlutter();
  await StorageService.init(); // open boxes here

  runApp(const ProviderScope(child: App()));
}
