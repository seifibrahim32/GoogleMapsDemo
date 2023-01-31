import 'package:json_annotation/json_annotation.dart';

part 'place_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceDetailsModel {
  @JsonKey(name: 'html_attributions')
  final List<dynamic> htmlAttributions;
  @JsonKey(name: 'result')
  final Map<String, dynamic> result;
  @JsonKey(name: 'status')
  final String status;

  PlaceDetailsModel({
    required this.htmlAttributions,
    required this.result,
    required this.status,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> map) =>
      _$PlaceDetailsModelFromJson(map);

  Map<String, dynamic> toJson() => _$PlaceDetailsModelToJson(this);
}
