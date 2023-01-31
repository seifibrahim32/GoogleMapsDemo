import 'package:equatable/equatable.dart';

abstract class MapStates extends Equatable {
  @override
  List<Object> get props => [];
}

class MapLoading extends MapStates {}

class MapInitialized extends MapStates {
  MapInitialized();

  @override
  List<Object> get props => [];
}
