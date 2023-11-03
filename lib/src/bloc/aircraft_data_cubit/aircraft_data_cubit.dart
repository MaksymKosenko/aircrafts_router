import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';

class AircraftDataCubit extends Cubit<Aircraft> {
  AircraftDataCubit({required this.aircraft}) : super(aircraft);

  final Aircraft aircraft;

  void changeTransportSpaceAmount(String spaceAmount) {
    aircraft.transportSpaceAmount = int.parse(spaceAmount);
  }

  void changeTransportationResourceCost(String transportationResourceCost) {
    aircraft.transportationResourceCost = int.parse(transportationResourceCost);
  }

  void changeAircraftCost(String aircraftCost) {
    aircraft.aircraftCost = int.parse(aircraftCost);
  }

  void changeAircraftTechnicalState(AircraftTechnicalState? state) {
    if (state == null) return;
    aircraft.aircraftTechnicalState = state;
  }
}
