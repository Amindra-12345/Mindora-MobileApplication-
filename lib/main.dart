import 'package:flutter/material.dart';

import 'screens/login_page.dart';
import 'theme/mindora_colors.dart';

void main() {
  runApp(const MindoraApp());
}

class MindoraApp extends StatelessWidget {
  const MindoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindora',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: MindoraColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: MindoraColors.primary),
      ),
      home: const LoginPage(),
    );
  }
}
