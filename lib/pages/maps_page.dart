import 'package:emergency_location/providers/maps_provider.dart';
import 'package:emergency_location/widgets/items.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    var mapsProvider = Provider.of<MapsProvider>(context);
    return Scaffold(
        body: Stack(
          alignment:Alignment.bottomCenter,
          children: [
            GoogleMap(
              initialCameraPosition: MapsProvider().currentCameraPosition,
              markers: MapsProvider().markers,
              onMapCreated: (controller) {
                MapsProvider().mapController = controller;
              },
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.20,
              decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color:Color.fromRGBO(0, 0, 0, 0.7)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Items(image: "assets/icons/siren.png", title: "Emergency"),
                          Items(image: "assets/icons/ambulance.png", title: "Ambulance"),
                          Items(image: "assets/icons/firetruck.png", title: "Firetruck"),
                          Items(image: "assets/icons/policecar.png", title: "Police"),
                        ],
                      ),
                    ]),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    Provider.of<MapsProvider>(context, listen: false).closeTracking();
    super.dispose();
  }
}
