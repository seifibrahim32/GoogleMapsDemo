import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'features/presentation/bloc/bloc_observer.dart';
import 'features/presentation/details_screen.dart';
import 'features/presentation/maps_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.unableToDetermine) {
    await Geolocator.requestPermission();
  }
  Bloc.observer = EventObserver();
  runApp(MaterialApp(
      routes: {'details-screen': (context) => DetailsScreen()},
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MapsScreen()));
}
