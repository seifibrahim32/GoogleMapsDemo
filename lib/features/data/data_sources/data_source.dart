import 'package:dio/dio.dart';

import '../models/maps_model.dart';

class MapsAPI {
  static String apiKey = 'AIzaSyCcZTaPgenENaD8W9rGxXVFCmBWTyhHZiU';
  static Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://maps.googleapis.com/maps/api/'
      )
  );

  static Future<MapsModel?> fetchNearPlaces(
      double latitude, double longitude,String query) async {
    Response result = await dio.get('place/nearbysearch/json?${query}location='
        '$latitude'
        '%2C$longitude&radius=1500&type=restaurant|gas_station&key=$apiKey');
    if (result.statusCode == 200) {
      print(MapsModel.fromJson(result.data).toJson());
      return  MapsModel.fromJson(result.data);
    }
  }
}