import 'package:flutter/material.dart';
import 'fearture/view/about_canada_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Canada",
      debugShowCheckedModeBanner: false,
      home: AboutCanadaPage(),
    );
  }
}
