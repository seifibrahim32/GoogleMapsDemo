import 'package:dio/dio.dart';

import '../repositories/maps_repository_impl.dart';

class MapsModel {
  String? nextPageToken;
  List<Results>? results = [];
  String? status;

  MapsModel(
      {required this.nextPageToken,
      required this.results,
      required this.status});

  MapsModel.fromJson(Map<String, dynamic> json) {
    nextPageToken = json['next_page_token'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page_token'] = this.nextPageToken;
    final results = this.results;
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
