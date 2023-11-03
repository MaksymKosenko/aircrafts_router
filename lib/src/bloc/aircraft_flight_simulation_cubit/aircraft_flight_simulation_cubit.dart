import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';

part 'aircraft_flight_simulation_state.dart';

class AircraftFlightSimulationCubit
    extends Cubit<AircraftFlightSimulationState> {
  static const _updateInterval = Duration(milliseconds: 50);
  static const _defaultAircraftSpeed = 100;

  AircraftFlightSimulationCubit(this.aircraftList)
      : super(AircraftFlightSimulationState(aircraftList: aircraftList));

  final List<Aircraft> aircraftList;

  Timer? simulationTimer;

  void startSimulation() {
    emit(state.copyWith(aircraftList: aircraftList));
    simulationTimer = Timer.periodic(_updateInterval, _updateAircraftPosition);
  }

  void _updateAircraftPosition(Timer timer) {
    final updatedAircraftList =
        state.aircraftList.map(_updateAircraft).toList();
    emit(state.copyWith(aircraftList: updatedAircraftList));
  }

  Aircraft _updateAircraft(Aircraft aircraft) {
    final route = aircraft.aircraftRoutes.first;
    final startPoint = route.startPoint.airportPosition.position;
    final endPoint = route.endPoint.airportPosition.position;

    final actualDistance = sqrt(pow(endPoint.dx - startPoint.dx, 2) +
        pow(endPoint.dy - startPoint.dy, 2));

    final distanceTraveled =
        _defaultAircraftSpeed * 0.001 * _updateInterval.inMilliseconds;

    aircraft.currentPosition += distanceTraveled / actualDistance;

    if (aircraft.currentPosition >= 0.99) {
      _changeAircraftState(aircraft, AircraftFlightState.completed);
      aircraft.currentPosition = 1.0;
    }

    return aircraft;
  }

  void stopSimulation() {
    simulationTimer?.cancel();
    state.aircraftList.forEach(_resetAircraftOffset);
    state.aircraftList.forEach((aircraft) =>
        _changeAircraftState(aircraft, AircraftFlightState.notStarted));
    emit(state.copyWith(aircraftList: aircraftList));
  }

  void _changeAircraftState(
      Aircraft aircraft, AircraftFlightState updatedState) {
    aircraft.flightState = updatedState;
  }

  void _resetAircraftOffset(Aircraft aircraft) {
    aircraft.currentPosition = 0.0;
  }

  Offset getDisplayAircraftPosition(Aircraft aircraft) {
    final startPoint =
        aircraft.aircraftRoutes.first.startPoint.airportPosition.position;
    final endPoint =
        aircraft.aircraftRoutes.first.endPoint.airportPosition.position;
    final currentPositionPercentage = aircraft.currentPosition;

    return Offset(
      startPoint.dx + (endPoint.dx - startPoint.dx) * currentPositionPercentage,
      startPoint.dy + (endPoint.dy - startPoint.dy) * currentPositionPercentage,
    );
  }
}
