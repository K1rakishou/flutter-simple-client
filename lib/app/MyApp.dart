import 'package:flutter/material.dart';
import 'package:flutter_simple_client/network/NetworkClient.dart';
import 'package:flutter_simple_client/screens/HomeScreen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  NetworkClient networkClient;

  MyApp() :
    networkClient = NetworkClient(http.Client());

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: new PhotosScreen(title: 'Flutter Home Page', client: networkClient),
    );
  }
}
