import 'package:database/home_page.dart';
import 'package:database/provider/auth_provider.dart';
import 'package:database/shared_preferencesd.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then((value) {
    preferences = value;
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) {
            return Providers();
          }),),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  });
}
