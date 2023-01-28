import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/maps_model.dart';
import 'bloc_states.dart';

class MapsCubit extends Cubit<MapStates> {
  MapsCubit() : super(MapLoading());

  static late Position position;

  static late final CameraPosition cameraPosition;
  final Set<Marker> markers = {};

  Future<MapsModel?> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    print('lat: ${position.latitude} , lang: ${position.longitude}');
    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId('Current'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(position.latitude, position.longitude),
    ));
    emit(LocationInitialized());
    return null;
  }

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
}
