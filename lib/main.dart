import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zehadis/AddisAbeba/Addis_Ketma.dart';
import 'package:zehadis/AddisAbeba/Kolefe.dart';
import 'package:zehadis/aboutApp.dart';
import 'package:zehadis/developer.dart';
import 'package:zehadis/homepage.dart';
import 'package:zehadis/AddisAbeba/bole.dart';
import 'package:zehadis/AddisAbeba/Lemi_KuraK.dart';
import 'package:zehadis/AddisAbeba/Yeka.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CountrySelectionPage(), routes: {
      '/lemi': (context) => Lemikura(), // Use dark theme for black background
      '/bole': (context) => bole(),
      '/yeka': (context) => Yeka(),
      '/profile': (context) => Developer(),
      '/aboutApp': (contect) => Aboutapp(),
      '/addis': (context) => AddisKetma(),
      'kolefe': (context) => Kolefe(),
    });
  }
}
