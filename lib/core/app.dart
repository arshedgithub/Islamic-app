import 'package:flutter/material.dart';
import 'theme.dart';
import 'main_shell.dart';

class ZikraApp extends StatelessWidget {
  const ZikraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zikra',
      theme: AppTheme.lightTheme,
      home: const MainShell(),
    );
  }
}
