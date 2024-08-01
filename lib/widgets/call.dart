import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/maps_provider.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MapsProvider>(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.20,
      decoration: const BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          color:Color.fromRGBO(255, 255, 255, .7)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Cancel"))
                ],
              ),
            ]),
      ),
    );
  }
}
