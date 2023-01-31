import 'package:dio/dio.dart';

import '../models/maps_model.dart';
import '../models/place_details_model.dart';

class MapsAPI {
  static String apiKey = '#Put your apiKey here';
  static Dio dio =
      Dio(BaseOptions(baseUrl: 'https://maps.googleapis.com/maps/api/'));
  static late Response? result;

  static Future<MapsModel?>? fetchNearPlaces(
      double latitude, double longitude, String query) async {
    result = await dio.get('place/nearbysearch/json?${query}location='
        '$latitude'
        '%2C$longitude&radius=1500&type=restaurant|gas_station&key=$apiKey');
    if (result?.statusCode == 200) {
      return MapsModel.fromJson(result?.data);
    }
  }

  static Future<PlaceDetailsModel?> getDetails(String placeId) async {
    result = await dio.get('place/details/json?place_id=$placeId&key'
        '=$apiKey');
    if (result?.statusCode == 200) {
      return PlaceDetailsModel.fromJson(result?.data);
    }
  }
}
