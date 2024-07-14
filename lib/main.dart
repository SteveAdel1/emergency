import 'package:emergency_location/pages/maps_page.dart';
import 'package:emergency_location/providers/maps_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapsProvider()..changeSettings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emergency location',
        home: MapsPage()
      ),
    );
  }
}

