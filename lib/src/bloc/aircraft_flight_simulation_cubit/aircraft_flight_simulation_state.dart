part of 'aircraft_flight_simulation_cubit.dart';

class AircraftFlightSimulationState {
  final List<Aircraft> aircraftList;
  final bool isRunningSimulation;

  AircraftFlightSimulationState(
      {required this.aircraftList, this.isRunningSimulation = false});

  AircraftFlightSimulationState copyWith({
    List<Aircraft>? aircraftList,
    bool? isRunningSimulation,
  }) {
    return AircraftFlightSimulationState(
      aircraftList: aircraftList ?? this.aircraftList,
      isRunningSimulation: isRunningSimulation ?? this.isRunningSimulation,
    );
  }
}
