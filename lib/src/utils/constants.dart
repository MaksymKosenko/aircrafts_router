import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';

class Constants {
  static const Map<AircraftTechnicalState, String>  aircraftTechnicalStates = {
    AircraftTechnicalState.excellent: 'Excellent',
    AircraftTechnicalState.good: 'Good',
    AircraftTechnicalState.fine: 'Fine',
    AircraftTechnicalState.bad: 'Bad',
    AircraftTechnicalState.critical: 'Critical',
  };

  static const Map<Priority, String> routePriorities = {
    Priority.critical: 'Critical',
    Priority.high: 'High',
    Priority.mid: 'Mid',
    Priority.low: 'Low',
  };

  static const Map<EmergencySituationOnTheRouter, String> emergencySituations =
      {
    EmergencySituationOnTheRouter.transportationObjectIssue:
        'Transportation Object Issue',
    EmergencySituationOnTheRouter.badWeather: 'Bad Weather',
    EmergencySituationOnTheRouter.aircraftBreakdown: 'Aircraft Breakdown',
    EmergencySituationOnTheRouter.none: 'None',
  };

  static const Map<AircraftFlightState, String> flightStates = {
    AircraftFlightState.notStarted: 'Not Started',
    AircraftFlightState.flying: 'Flying',
    AircraftFlightState.completed: 'Completed',
  };
}
