import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/data_sources/data_source.dart';
import '../../data/models/maps_model.dart';
import '../../data/repositories/maps_repository_impl.dart';
import 'bloc_states.dart';

class MapsCubit extends Cubit<MapStates> {
  MapsCubit() : super(MapLoading());


  Set<Marker> markers = {};

  static late Position position;

  static late final CameraPosition cameraPosition;
  TextStyle? productSansStyle =
      const TextStyle(fontFamily: 'Product Sans', fontSize: 20);

  connectInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      log(connectivityResult.name);
      getLocation();
    } else {
      emit(MapLoading());
    }
  }

  Future<MapsModel?> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
    } on Exception catch (error) {
      log(error.toString());
    }
    log('lat: ${position.latitude} ,lang: ${position.longitude}');
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('Current'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(position.latitude, position.longitude),
    ));
    emit(LocationInitialized());
  }

  Future<MapsModel?> fetchNearPlaces(BuildContext context,{required String query}) async {

    var data = await MapsAPI.fetchNearPlaces(position.latitude, position.longitude, query);

    if(query.isNotEmpty){
      markers.clear();

      data?.results?.forEach((result) {
        markers.add(Marker(
            markerId: MarkerId(result.name!),
            infoWindow: InfoWindow(title: result.name),
            onTap: () {
              showBottomSheet(context, result);
            },
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(
                result.geometry!.location!.lat!, result.geometry!.location!.lng!)));
      });
      print('isNotEmpty');
      emit(MapUpdated());
    }
    else {
      print('isEmpty');
      markers.clear();
      data?.results?.forEach((result) {
        markers.add(Marker(
            markerId: MarkerId(result.name!),
            infoWindow: InfoWindow(title: result.name),
            onTap: () {
              showBottomSheet(context, result);
            },
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(
                result.geometry!.location!.lat!, result.geometry!.location!.lng!)));
      });
      emit(MapInitialized());
    }
    return data;

  }

  showBottomSheet(BuildContext context, Results result) async {
    return await showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(result.name!, style: productSansStyle),
              ),
              Container(height: 2, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.black
                              ),
                              child: Image.network('https://maps.googleapis.com/'
                                  'maps/api/place/photo?maxwidth=1000'
                                  '&photo_reference=${result.photos![index].photoReference??
                                  result.photos![index-1].photoReference}'
                                  '&key=AIzaSyAiLo2-Ngxz-KjtvIGb7eHy7xmc4BgVjys',
                                  scale:0.1,
                              errorBuilder: (ctx,object,stack){
                                return CircularProgressIndicator();
                              },)
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10);
                        },
                        itemCount: result.photos!.length,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('details-screen');
                    },
                    child: Text('Show more...',style:productSansStyle),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
