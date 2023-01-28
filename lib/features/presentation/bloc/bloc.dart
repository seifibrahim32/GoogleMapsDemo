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

  List<Results> results = [];

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
    return null;
  }

  Future<MapsModel?> fetchNearPlaces({String query = ''}) async {
    var data = await MapsAPI.fetchNearPlaces(position.latitude, position.longitude, query);
    emit(MapInitialized());
    return data;

  }
}
