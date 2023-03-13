import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_new_project/di/createDependencies.dart';
import 'package:test_new_project/presentation/screens/root_screen.dart';

Future<Map<String, dynamic> > getRandomCocktail() async {
  final response = await http.post(
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    //return Album.fromJson(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
/*
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}*/

void main() {
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
  Future<Map<String, dynamic>>? _futureCocktail;

  @override
  Widget build(BuildContext context) {
    createDependencies();

    return MaterialApp(
      title: 'Create Data Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        /*appBar: AppBar(
          title: const Text('Create Data Example'),
        ),*/
        body:
          RootWidget()
        /*Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureCocktail == null) ? buildColumn() : buildFutureBuilder(),
        ),*/
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureCocktail = getRandomCocktail();
            });
          },
          child: const Text('Get cocktail'),
        ),
      ],
    );
  }

  FutureBuilder<Map<String, dynamic>> buildFutureBuilder() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _futureCocktail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!['drinks'][0]['strDrink']);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}