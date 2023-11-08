import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

class Aircraft {
  Aircraft({
    required this.name,
    required this.baseAircraftPosition,
    required this.aircraftRoutes,
    required this.aircraftTechnicalState,
    required this.fuelAmount,
    required this.transportSpaceAmount,
    required this.aircraftCost,
    required this.transportationResourceCost,
  })  : maxFuelAmount = fuelAmount,
        flightState = AircraftFlightState.notStarted;

  ///Aircraft name
  final String name;

  AirportPosition baseAircraftPosition;

  List<AircraftRoute> aircraftRoutes;

  ///Value from 0 to 1, which represents current position on the route.
  ///0 means the start point, 1 means end point.
  ///In case when 'transitionPoint' of the Route is != null
  ///end point is transitionPoint.
  ///After reaching the transitionPoint, it will become a startPoint
  ///and real endPoint will be the end point.
  double currentPosition = 0.0;

  ///Aircraft technical state, used to calculate risks
  AircraftTechnicalState aircraftTechnicalState;

  AircraftFlightState flightState;

  ///Maximal fuel amount in liters
  final double maxFuelAmount;

  ///Current fuel amount in liters
  double fuelAmount;

  ///Space available for transportation of luggage or people
  int transportSpaceAmount;

  ///Cost of the Aircraft
  int aircraftCost;

  ///Cost of the luggage or people
  int transportationResourceCost;
}

enum AircraftFlightState {
  notStarted,
  flying,
  completed,
}

enum AircraftTechnicalState {
  excellent,
  fine,
  good,
  bad,
  critical,
}
