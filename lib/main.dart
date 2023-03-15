import 'package:flutter/material.dart';
import 'package:test_new_project/di/createDependencies.dart' as di;

import 'random_cocktail_feature/presentation/screens/root_screen.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Create Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body:
          RootWidget()
      ),
    );
  }
}