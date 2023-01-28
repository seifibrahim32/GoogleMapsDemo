import 'package:equatable/equatable.dart';

abstract class MapStates extends Equatable {
  @override
  List<Object> get props => [];
}

class MapLoading extends MapStates {}

class LocationInitialized extends MapStates {}

class MapInitialized extends MapStates {}

class MapUpdated extends MapStates {}
