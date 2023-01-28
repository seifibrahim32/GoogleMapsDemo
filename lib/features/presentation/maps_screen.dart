import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/models/maps_model.dart';
import '../data/repositories/maps_repository_impl.dart';
import 'bloc/bloc.dart';
import 'bloc/bloc_states.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => MapsCubit(),
        child: BlocBuilder<MapsCubit, MapStates>(
          builder: (context, state) {
            if (state is MapLoading) {
              BlocProvider.of<MapsCubit>(context).connectInternet();
              return const CircularProgressIndicator();
            } else if (state is LocationInitialized){
              return Center(
                  child: Text(
                'Location Detected',
                style: productSansStyle,
              ));
            } else if (state is MapInitialized || state is MapUpdated) {
              return FutureBuilder<MapsModel?>(
                future: BlocProvider.of<MapsCubit>(context).fetchNearPlaces(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('Model ${snapshot.data!.toJson()}');
                    print('Model ${snapshot.hasData}');
                    if (snapshot.connectionState != ConnectionState.done) {
                      snapshot.data?.results?.forEach((result) {
                        createNewMarkers(context, result);
                      });
                      return const CircularProgressIndicator(
                        color: Colors.black,
                      );
                    }
                    else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.hybrid,
                            markers:
                                BlocProvider.of<MapsCubit>(context).markers,
                            initialCameraPosition: MapsCubit.cameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
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
                                      onSubmitted: (query) async {
                                        BlocProvider.of<MapsCubit>(context)
                                            .fetchNearPlaces(
                                                query: 'keyword=$query&');
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
                  }
                  return Container(color: Colors.purpleAccent);
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

  createNewMarkers(BuildContext context, Results result) {
    BlocProvider.of<MapsCubit>(context).markers.add(Marker(
        markerId: MarkerId(result.name!),
        infoWindow: InfoWindow(title: result.name),
        onTap: () {
          showBottomSheet(context, result);
        },
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(
            result.geometry!.location!.lat!, result.geometry!.location!.lng!)));
  }

  showBottomSheet(BuildContext context, Results result) async {
    return await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(result.name!, style: productSansStyle),
                Container(height: 4, color: Colors.grey),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 151,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.black),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10);
                    },
                    itemCount: 13,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('details-screen');
                  },
                  child: const Text('Show more...'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
