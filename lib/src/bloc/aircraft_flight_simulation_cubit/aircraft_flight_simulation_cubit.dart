import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:aircrafts_router/src/algorithm_util/algorithm_util.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
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
    emit(state.copyWith(aircraftList: aircraftList, isRunningSimulation: true));
    simulationTimer = Timer.periodic(_updateInterval, _updateAircraftPosition);
  }

  void _updateAircraftPosition(Timer timer) {
    final updatedAircraftList =
        state.aircraftList.map(_updateAircraft).toList();
    emit(state.copyWith(aircraftList: updatedAircraftList));
  }

  Aircraft _updateAircraft(Aircraft aircraft) {
    final route = aircraft.aircraftRoutes.first;

    Offset? transitionPoint = route.transitionPoint?.airportPosition.position;
    Offset startPoint = route.startPoint.airportPosition.position;
    if (aircraft.baseAircraftPosition.airportPosition.position != startPoint) {
      transitionPoint = startPoint;
      startPoint = aircraft.baseAircraftPosition.airportPosition.position;
    }
    Offset endPoint = route.endPoint.airportPosition.position;

    if (aircraft.isReachedTransitionPoint && transitionPoint != null) {
      startPoint = transitionPoint;
      transitionPoint = null;
    }

    double actualDistance;
    double distanceTraveled =
        _defaultAircraftSpeed * 0.001 * _updateInterval.inMilliseconds;

    if (aircraft.currentPosition < 1.0) {
      if (transitionPoint != null) {
        endPoint = transitionPoint;
      }
      actualDistance = sqrt(pow(endPoint.dx - startPoint.dx, 2) +
          pow(endPoint.dy - startPoint.dy, 2));
      aircraft.currentPosition += distanceTraveled / actualDistance;
    } else if (aircraft.currentPosition >= 1.0 &&
        aircraft.isReachedTransitionPoint == false &&
        route.transitionPoint != null) {
      aircraft.isReachedTransitionPoint = true;

      startPoint = route.transitionPoint!.airportPosition.position;
      endPoint = route.endPoint.airportPosition.position;
      actualDistance = sqrt(pow(endPoint.dx - startPoint.dx, 2) +
          pow(endPoint.dy - startPoint.dy, 2));
      aircraft.currentPosition = distanceTraveled / actualDistance;
    } else if (aircraft.currentPosition >= 1.0 &&
        aircraft.baseAircraftPosition != route.startPoint &&
        route.transitionPoint == null) {
      aircraft.currentPosition = 0;
      aircraft.baseAircraftPosition = route.startPoint;
    } else {
      _changeAircraftState(aircraft, AircraftFlightState.completed);
      //TODO implement later
      aircraft.baseAircraftPosition = aircraft.aircraftRoutes.first.endPoint;
      aircraft.aircraftRoutes = [];
      AircraftRoute? nextRoute = AlgorithmUtil().getNextRoute(aircraft);
      aircraft = getNullifiedAircraft(aircraft);

      if (nextRoute != null) {
        aircraft.aircraftRoutes.add(nextRoute);
        AlgorithmUtil().removeFromList(nextRoute);
      }
    }

    return aircraft;
  }

  void stopSimulation() {
    simulationTimer?.cancel();
    emit(
        state.copyWith(aircraftList: aircraftList, isRunningSimulation: false));
  }

  void restartSimulation() {
    simulationTimer?.cancel();
    state.aircraftList.forEach(_resetAircraftOffset);
    state.aircraftList.forEach((aircraft) {
      _changeAircraftState(aircraft, AircraftFlightState.notStarted);
      aircraft.isReachedTransitionPoint = false;
    });

    emit(
        state.copyWith(aircraftList: aircraftList, isRunningSimulation: false));
  }

  void _changeAircraftState(
      Aircraft aircraft, AircraftFlightState updatedState) {
    aircraft.flightState = updatedState;
  }

  void _resetAircraftOffset(Aircraft aircraft) {
    aircraft.currentPosition = 0.0;
  }

  Aircraft getNullifiedAircraft(Aircraft aircraft) {
    Aircraft _aircraft = Aircraft(
      name: aircraft.name,
      baseAircraftPosition: aircraft.baseAircraftPosition,
      aircraftRoutes: [],
      aircraftTechnicalState: aircraft.aircraftTechnicalState,
      fuelAmount: aircraft.fuelAmount,
      transportSpaceAmount: aircraft.transportSpaceAmount,
      aircraftCost: aircraft.aircraftCost,
      transportationResourceCost: aircraft.transportationResourceCost,
    );
    return _aircraft
      ..isReachedTransitionPoint = false
      ..flightState = AircraftFlightState.notStarted
      ..currentPosition = 0;
  }

  Offset getDisplayAircraftPosition(
      Aircraft aircraft, Offset start, Offset target) {
    final startPoint = start;
    final endPoint = target;
    final currentPositionPercentage = aircraft.currentPosition;

    return Offset(
      startPoint.dx + (endPoint.dx - startPoint.dx) * currentPositionPercentage,
      startPoint.dy + (endPoint.dy - startPoint.dy) * currentPositionPercentage,
    );
  }
}
