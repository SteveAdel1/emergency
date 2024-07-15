import 'dart:async';
import 'package:emergency_location/providers/maps_provider.dart';
import 'package:emergency_location/widgets/items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _completer = Completer();
  late String mapStyleString;
  @override
  void initState() {
    rootBundle.loadString('assets/google_maps_theme.json').
    then((asset) {
      mapStyleString = asset;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MapsProvider>(context);
    return Scaffold(
        body: Stack(
              alignment:Alignment.bottomCenter,
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: MapsProvider().currentCameraPosition,
                  markers: MapsProvider().markers,
                  onMapCreated: (controller) {
                    MapsProvider().mapController = controller;

                    _completer.complete(controller);
                    _completer.future.then((value) {
                      value.setMapStyle(mapStyleString);
                    });

                  },
                ),
                vm.click ?
                Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 40,),
                              ElevatedButton(onPressed: () {
                                vm.isClicked();

                              }, child: Text("Cancel"))


                            ],
                          ),
                        ]),
                  ),
                ):
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.20,
                  decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color:Color.fromRGBO(255, 255, 255, 0.7)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    print("click");
                                    vm.isClicked();
                                  }
                                  ,child: Items(image: "assets/icons/siren.png", title: "Emergency")),
                              InkWell(
                                  onTap: () {
                                    print("click");
                                    vm.isClicked();
                                  },
                                  child: Items(image: "assets/icons/ambulance.png", title: "Ambulance")),
                              InkWell(
                                  onTap: () {
                                    print("click");
                                    vm.isClicked();
                                  },
                                  child: Items(image: "assets/icons/firetruck.png", title: "Firetruck")),
                              InkWell(
                                  onTap: () {
                                    print("click");
                                    vm.isClicked();
                                  },
                                  child: Items(image: "assets/icons/policecar.png", title: "Police")),


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
