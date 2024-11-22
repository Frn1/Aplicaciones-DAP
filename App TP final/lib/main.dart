// Flutter imports:
import 'package:app_tp_final/models/user.dart';
import 'package:app_tp_final/providers/user.dart';
import 'package:app_tp_final/shared_preferences.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '/firebase_options.dart';
import '/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedPreferences = await getSharedPreferences();
  if (sharedPreferences.containsKey("username") &&
      sharedPreferences.containsKey("password")) {
    user = User(sharedPreferences.getString("username")!,
        sharedPreferences.getString("password")!);
  }

  runApp(ProviderScope(
    child: Builder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
      );
    }),
  ));
}
