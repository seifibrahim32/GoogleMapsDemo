import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({Key? key}) : super(key: key);
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController searchController = TextEditingController();

  TextStyle? productSansStyle = TextStyle(
      fontFamily: 'Product Sans',
      fontSize: 20
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Column(
            children: [
              SizedBox(height:62),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurStyle:BlurStyle.outer,
                          color:Colors.white70,
                          blurRadius: 3,
                          offset: Offset(
                              14,4
                          )
                      ),
                      BoxShadow(
                          color:Colors.grey,
                          blurRadius: 3,
                          offset: Offset(
                              -2,1
                          )
                      ),
                      BoxShadow(
                          color:Colors.grey,
                          blurRadius: 3,
                          offset: Offset(
                              0,1
                          )
                      ),
                      BoxShadow(
                          color:Colors.grey,
                          blurRadius: 3,
                          offset: Offset(
                              0,-2
                          )
                      )
                    ]
                ),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      enabled: true,
                      style: productSansStyle,
                      maxLines: 1,
                      onSubmitted: (text) {},
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle:  productSansStyle,
                        prefixIcon: Icon(Icons.map),
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(top:10,right:20),
                        hintText: 'Search for places...',
                        fillColor: Colors.black,
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
