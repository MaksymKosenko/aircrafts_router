import 'dart:math';

import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

import '../algorithm_util/models/aircraft.dart';
import '../algorithm_util/models/aircraft_route.dart';

class ResourceTrackerBloc {
  static const double planePositionMoveDistance = 0.5;
  static const double fuelPerOneTick = 0.1;
  static const double lowerLimitOfFuel = 8;

  void changeAirportResources(Airport airport, Aircraft aircraft) {
    if (aircraft.currentPosition == 1) {
      airport.currentAircraftAmount++;
    } else if (aircraft.currentPosition == 0) {
      airport.currentAircraftAmount--;
    }
  }

  // void changeAllAirportsResources(List<Airport> airports) {
  //   airports.forEach((airport) {
  //     changeAirportResources(airport);
  //   });
  // }

  void changeAircraftResource(Aircraft aircraft) {
    if (aircraft.currentPosition != 1) {
      aircraft.fuelAmount -= fuelPerOneTick;
      aircraft.currentPosition = getAircraftNewPosition(
          aircraft.aircraftRoutes.first, aircraft.currentPosition);
    } else {
      aircraft.aircraftRoutes.removeAt(0);
      if (aircraft.aircraftRoutes.isNotEmpty) {
        aircraft.currentPosition = 0;
      }
    }
  }

  double getAircraftNewPosition(
      AircraftRoute aircraftCurrentRoute, double currentPosition) {
    double distanceBetweenStartEnd = distanceBetweenTwoPoints(
        aircraftCurrentRoute.startPoint.airportPosition,
        aircraftCurrentRoute.endPoint.airportPosition);

    if (currentPosition == 0) {
      return getDifferenceInPercents(distanceBetweenStartEnd);
    }
    if (currentPosition + getDifferenceInPercents(distanceBetweenStartEnd) >=
        1) {
      return 1;
    } else {
      return currentPosition + getDifferenceInPercents(distanceBetweenStartEnd);
    }
  }

  double getDifferenceInPercents(double distanceBetweenStartEnd) {
    return 1 -
        ((distanceBetweenStartEnd - planePositionMoveDistance) /
            distanceBetweenStartEnd);
  }

  double distanceBetweenTwoPoints(AirportPosition a, AirportPosition b) {
    return sqrt(
      pow(a.position.dx - b.position.dx, 2) +
          pow(a.position.dy - b.position.dy, 2),
    );
  }

  //void changeAllAircraftsResource(Aircraft aircraft) {}

  void processTrackingTick(
      List<AircraftRoute> currentRoutes, List<Aircraft> activePlanes) {
    activePlanes.forEach((aircraft) {
      if (aircraft.currentPosition == 1) {
        currentRoutes.forEach((route) {
          if (route == aircraft.aircraftRoutes.first) {
            changeAirportResources(route.endPoint, aircraft);
          }
          if (aircraft.fuelAmount <= lowerLimitOfFuel) {
            route.endPoint.fuelAmount -=
                (aircraft.maxFuelAmount - aircraft.fuelAmount);
            aircraft.fuelAmount +=
                (aircraft.maxFuelAmount - aircraft.fuelAmount);
          }
        });
      }

      changeAircraftResource(aircraft);
    });
  }
}
