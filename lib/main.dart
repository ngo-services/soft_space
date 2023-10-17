import 'package:flutter/material.dart';
import 'package:soft_space/calculator_screen.dart';
import 'package:soft_space/data_entry_screen.dart';
import 'package:soft_space/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataEntryScreen(),
    );
  }
}
