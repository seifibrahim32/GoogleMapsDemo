import 'package:bloc/bloc.dart';
import 'package:turing_assessment/features/data/data_sources/data_source.dart';
import 'package:turing_assessment/features/presentation/bloc/states/places_states.dart';

class DetailsMapsCubit extends Cubit<DetailsStates> {
  DetailsMapsCubit() : super(DetailsLoading());

  dynamic data;

  loadData(String placeId) async {
    var data = await MapsAPI.getDetails(placeId);
    Map<String, dynamic> dataMap = data!.toJson();
    emit(DataLoaded(dataMap));
  }
}
