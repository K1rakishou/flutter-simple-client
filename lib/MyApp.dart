import 'package:flutter/material.dart';
import 'package:flutter_simple_client/InjectionContainer.dart';
import 'package:flutter_simple_client/features/PhotosScreen.dart';

void main() {
  initKiwi();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: new PhotosScreen(),
    );
  }
}
