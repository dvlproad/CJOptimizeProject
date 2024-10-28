import 'package:flutter/material.dart';

import 'ts_optimize_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '检测 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TSOptimizeHomePage(),
    );
  }
}
