import 'package:database/edit_screen.dart';
import 'package:database/shared_preferencesd.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then((value) {
    preferences = value;
    runApp(
      const MaterialApp(
        home: EditScreen(),
      ),
    );
  });
}
