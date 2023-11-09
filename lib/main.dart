import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'countup.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    final theme = ThemeData.dark(useMaterial3: true).copyWith(
      useMaterial3: true,
    );

    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: theme,
      home: const CountUpTimerPage(),
    );
  }
}
