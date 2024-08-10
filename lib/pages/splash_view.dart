import 'package:emergency_location/pages/maps_page.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 10),
            () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MapsPage()),
            ) );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:  BoxDecoration(
    image: DecorationImage(
    image: AssetImage(
    "assets/images/splash.jpg",
    ),
    //fit: BoxFit.cover
    ))
    );
  }
}
