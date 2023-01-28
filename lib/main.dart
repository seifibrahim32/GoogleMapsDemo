import 'package:flutter/material.dart';

import 'features/presentation/maps_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
    ),
    debugShowCheckedModeBanner: false,
      home: MapsScreen())
  );
}
