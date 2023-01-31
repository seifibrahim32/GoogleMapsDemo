import 'package:equatable/equatable.dart';

class DetailsStates extends Equatable{

  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsStates {}

class DataLoaded extends DetailsStates {
  Map<String,dynamic>? data = {};
  DataLoaded(this.data);
  @override
  List<Object> get props => [data!];
}

