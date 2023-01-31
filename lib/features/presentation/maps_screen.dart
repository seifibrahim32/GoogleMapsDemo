import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/maps_model.dart';
import 'bloc/bloc.dart';
import 'bloc/states/map_states.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController searchController = TextEditingController();

  TextStyle? productSansStyle =
      const TextStyle(fontFamily: 'Product Sans', fontSize: 20);
  String? query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (BuildContext context) => MapsCubit(),
        child: BlocBuilder<MapsCubit, MapStates>(
          builder: (ctx, state) {
            if (state is MapLoading) {
              BlocProvider.of<MapsCubit>(ctx).connectInternet();
              return const CircularProgressIndicator();
            } else if (state is MapInitialized) {
              return FutureBuilder<MapsModel?>(
                future: BlocProvider.of<MapsCubit>(ctx).fetchNearPlaces(context,
                    query: query!.isEmpty ? '' : 'keyword=$query&'),
                builder: (ctx, snapshot) {
                  print(snapshot.connectionState.name);
                  if (snapshot.hasData) {
                    return Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.hybrid,
                          markers: MapsCubit.markers,
                          initialCameraPosition: MapsCubit.cameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            if (!_controller.isCompleted) {
                              _controller.complete(controller);
                            } else {}
                          },
                        ),
                        //Search bar
                        Column(
                          children: [
                            const SizedBox(height: 62),
                            Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurStyle: BlurStyle.outer,
                                        color: Colors.white70,
                                        blurRadius: 3,
                                        offset: Offset(14, 4)),
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(-2, 1)),
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(0, 1)),
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(0, -2))
                                  ]),
                              child: Row(children: [
                                Expanded(
                                  child: TextField(
                                    enabled: true,
                                    style: productSansStyle,
                                    maxLines: 1,
                                    onSubmitted: (query) {
                                      setState((){
                                        this.query = query;
                                      });
                                    },
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: productSansStyle,
                                      prefixIcon: const Icon(Icons.map),
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, right: 20),
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
                    );
                  }
                  return CircularProgressIndicator(color: Colors.black);
                },
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheHome,
        label: const Text('To the home!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(MapsCubit.cameraPosition));
  }

  Future showError(BuildContext ctx) async {
    return Dialog(
        child: Scaffold(
      body: Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            Text('The query found 0', style: productSansStyle)
          ])),
    ));
  }
}
