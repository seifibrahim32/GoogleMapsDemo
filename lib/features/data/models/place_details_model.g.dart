// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailsModel _$PlaceDetailsModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailsModel(
      htmlAttributions: json['html_attributions'] as List<dynamic>,
      result: json['result'] as Map<String, dynamic>,
      status: json['status'] as String,
    );

Map<String, dynamic> _$PlaceDetailsModelToJson(PlaceDetailsModel instance) =>
    <String, dynamic>{
      'html_attributions': instance.htmlAttributions,
      'result': instance.result,
      'status': instance.status,
    };
