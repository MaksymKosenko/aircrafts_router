part of 'aircraft_flight_simulation_cubit.dart';

class AircraftFlightSimulationState {
  final List<Aircraft> aircraftList;

  AircraftFlightSimulationState({required this.aircraftList});

  AircraftFlightSimulationState copyWith({List<Aircraft>? aircraftList}) {
    return AircraftFlightSimulationState(
      aircraftList: aircraftList ?? this.aircraftList,
    );
  }
}
