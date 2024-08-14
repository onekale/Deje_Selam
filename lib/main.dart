import 'package:flutter/material.dart';
import 'package:zehadis/aboutApp.dart';
import 'package:zehadis/developer.dart';
import 'package:zehadis/homepage.dart';
import 'package:zehadis/AddisAbeba/bole.dart';
import 'package:zehadis/AddisAbeba/Lemi_KuraK.dart';
import 'package:zehadis/AddisAbeba/Yeka.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), routes: {
      '/lemi': (context) => Lemikura(), // Use dark theme for black background
      '/bole': (context) => bole(),
      '/yeka': (context) => Yeka(),
      '/profile': (context) => Developer(),
      '/aboutApp': (contect) => Aboutapp()
    });
  }
}
