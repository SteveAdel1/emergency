import 'dart:async';
import 'package:emergency_location/pages/test.dart';
import 'package:emergency_location/providers/maps_provider.dart';
import 'package:emergency_location/widgets/call.dart';
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
    return SafeArea(
      child: Scaffold(
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
                      child:
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red, // background color
                                    ),
      
                                    onPressed: ()
                                {
                                  print("request");
                                  showModalBottomSheet(
                                    //backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => Test(),
                                  );
                                },
                                    child: Text("Request" ,
                                      style: TextStyle(color: Colors.white),)),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     ElevatedButton(
                                //         style: ElevatedButton.styleFrom(
                                //             fixedSize: Size(150, 20),
                                //         alignment: Alignment.center
                                //         )
                                //             ,onPressed: () {
                                //       showModalBottomSheet(
                                //         //backgroundColor: Colors.transparent,
                                //         context: context,
                                //         builder: (context) => Call(),
                                //       );
                                //     }, child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //       Icon(Icons.call),
                                //       Text("Call",textAlign: TextAlign.center,)
                                //     ],)),
                                //     ElevatedButton(
                                //         style: ElevatedButton.styleFrom(
                                //             fixedSize: Size(150, 20),
                                //             alignment: Alignment.center
                                //         )
                                //         ,onPressed: () {
                                //         showModalBottomSheet(
                                //           //backgroundColor: Colors.transparent,
                                //           context: context,
                                //           builder: (context) => Call(),
                                //         );
                                //     }, child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Icon(Icons.video_call),
                                //         Text("Vadio Call",textAlign: TextAlign.center,)
                                //       ],)),
                                //   ],
                                // ),
                                ElevatedButton(onPressed: ()
                                {
                                      vm.isClicked();

                                }, child: Text("Cncel"))
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
                                    },
                                    child: Items(
                                        image: "assets/icons/ambulance.png" , title: "Ambulance")),
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
                                InkWell(
                                    onTap: () {
                                      print("click");
                                      vm.isClicked();
                                    }
                                    ,child: Items(image: "assets/icons/accident.png", title: "Accident")),
                              ],
                            ),
                          ]),
                    ),
                  )
                ],
          )),
    );
  }

  @override
  void dispose() {
    Provider.of<MapsProvider>(context, listen: false).closeTracking();
    super.dispose();
  }
}
