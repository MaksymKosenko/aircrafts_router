import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_item_state.dart';

class SelectedItemCubit extends Cubit<SelectedItemState> {
  SelectedItemCubit() : super(SelectedItemState());

  Stream<SelectedItemState> get selectedItemsStream =>
      stream.asBroadcastStream();

  void selectAirport(Airport airport) {
    emit(SelectedItemState.withAirport(airport));
  }

  void selectAircraft(Aircraft aircraft) {
    emit(SelectedItemState.withAircraft(aircraft));
  }
}
