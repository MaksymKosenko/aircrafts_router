import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

import 'models/aircraft.dart';
import 'models/aircraft_route.dart';
import 'models/transportation_resource.dart';
import 'package:flutter/cupertino.dart';

class AlgorithmUtil {
  AlgorithmUtil._privateConstructor();

  static final AlgorithmUtil _instance = AlgorithmUtil._privateConstructor();

  factory AlgorithmUtil() {
    return _instance;
  }

  final List<AircraftRoute> _generatedRoutes = [];

  List<AircraftRoute> get generatedRoutes => _generatedRoutes;

  //Should be moved to bloc
  final List<Aircraft> _aircrafts = [];

  //Should be moved to bloc
  List<Aircraft> get aircrafts => _aircrafts;

  //Should be moved to bloc
  final List<Airport> _airports = [];

  final List<TransportationResource> _criticalPriorityRoutes = [];

  final List<TransportationResource> _highPriorityRoutes = [];

  final List<TransportationResource> _midPriorityRoutes = [];

  final List<TransportationResource> _lowPriorityRoutes = [];

  void generateStartRoutes(
    List<Airport> airports,
    List<TransportationResource> transportationResources,
    List<Aircraft> planes,
  ) {
    _airports.addAll(airports);
    _criticalPriorityRoutes
        .addAll(sortByPriority(transportationResources, Priority.critical));

    _highPriorityRoutes
        .addAll(sortByPriority(transportationResources, Priority.high));

    _midPriorityRoutes
        .addAll(sortByPriority(transportationResources, Priority.mid));

    _lowPriorityRoutes
        .addAll(sortByPriority(transportationResources, Priority.low));

    planes.forEach((plane) {
      AircraftRoute? nextRoute = getNextRoute(plane);
      if (nextRoute != null) {
        removeFromList(nextRoute);
        _generatedRoutes.add(getAdditionalTransitionIfNeeded(plane, nextRoute));
        plane.aircraftRoutes
            .add(getAdditionalTransitionIfNeeded(plane, nextRoute));
        _aircrafts.add(plane);
      }
    });
  }

  AircraftRoute getAdditionalTransitionIfNeeded(
      Aircraft plane, AircraftRoute route) {
    AirportPosition routeStartPosition = plane.aircraftRoutes.isEmpty
        ? plane.baseAircraftPosition.airportPosition
        : route.startPoint.airportPosition;

    if (routeStartPosition != route.startPoint.airportPosition) {
      var start = _airports.firstWhere((element) =>
          element.airportPosition.position == routeStartPosition.position);

      var test = AircraftRoute(
        name: "Route From${plane.baseAircraftPosition}to${route.endPoint.name}",
        startPoint: start,
        transitionPoint: route.startPoint,
        endPoint: route.endPoint,
        routeProfit: route.routeProfit,
        routePriority: route.routePriority,
      );

      return AircraftRoute(
        name: "Route From${plane.baseAircraftPosition}to${route.endPoint.name}",
        startPoint: _airports.firstWhere((element) =>
            element.airportPosition.position == routeStartPosition.position),
        transitionPoint: route.startPoint,
        endPoint: route.endPoint,
        routeProfit: route.routeProfit,
        routePriority: route.routePriority,
      );
    } else {
      return route;
    }
  }

  void removeFromList(AircraftRoute route) {
    if (route.routePriority == Priority.critical) {
      _criticalPriorityRoutes.remove(getTransportationResourceFromAircraftRoute(
          route, _criticalPriorityRoutes));
    } else if (route.routePriority == Priority.high) {
      _highPriorityRoutes.remove(getTransportationResourceFromAircraftRoute(
          route, _highPriorityRoutes));
    } else if (route.routePriority == Priority.mid) {
      _midPriorityRoutes.remove(getTransportationResourceFromAircraftRoute(
          route, _midPriorityRoutes));
    } else if (route.routePriority == Priority.low) {
      _lowPriorityRoutes.remove(getTransportationResourceFromAircraftRoute(
          route, _lowPriorityRoutes));
    }
  }

  TransportationResource getTransportationResourceFromAircraftRoute(
      AircraftRoute route, List<TransportationResource> listOfRoutes) {
    return listOfRoutes.firstWhere((element) =>
        element.startPoint == route.startPoint &&
        element.endPoint == route.endPoint &&
        element.amount * element.costPerUnit == route.routeProfit);
  }

  List<TransportationResource> sortByPriority(
      List<TransportationResource> transportationResources, Priority priority) {
    var prioritizedRoutes = transportationResources
        .where((element) => element.priority == priority);
    return sortByProfit(prioritizedRoutes.toList());
  }

  List<TransportationResource> sortByProfit(
      List<TransportationResource> transportationResources) {
    transportationResources
        .sort((a, b) => getProfit(a).compareTo(getProfit(b)));
    return transportationResources.reversed.toList();
  }

  int getProfit(TransportationResource transportationResource) {
    return transportationResource.amount * transportationResource.costPerUnit;
  }

  bool didPlaneCanPickup(int planeSpaceAmount, int resourceAmount) {
    return planeSpaceAmount >= resourceAmount ? true : false;
  }

  AircraftRoute? getNextRoute(Aircraft plane) {
    AirportPosition routeStartPosition = plane.aircraftRoutes.isEmpty
        ? plane.baseAircraftPosition.airportPosition
        : plane.aircraftRoutes.first.endPoint.airportPosition;

    if (_criticalPriorityRoutes.isNotEmpty) {
      try {
        return getAircraftRouteFromTransportationResource(
            getFirstSuitableTransportation(routeStartPosition,
                plane.transportSpaceAmount, _criticalPriorityRoutes));
      } catch (e) {
        print("No suitable objects in _criticalPriorityRoutes list");
      }
    } else if (_highPriorityRoutes.isNotEmpty) {
      try {
        return getAircraftRouteFromTransportationResource(
            getFirstSuitableTransportation(routeStartPosition,
                plane.transportSpaceAmount, _highPriorityRoutes));
      } catch (e) {
        print("No suitable objects in _highPriorityRoutes list");
      }
    } else if (_midPriorityRoutes.isNotEmpty) {
      try {
        return getAircraftRouteFromTransportationResource(
            getFirstSuitableTransportation(routeStartPosition,
                plane.transportSpaceAmount, _midPriorityRoutes));
      } catch (e) {
        print("No suitable objects in _midPriorityRoutes list");
      }
    } else if (_lowPriorityRoutes.isNotEmpty) {
      try {
        return getAircraftRouteFromTransportationResource(
            getFirstSuitableTransportation(routeStartPosition,
                plane.transportSpaceAmount, _lowPriorityRoutes));
      } catch (e) {
        print("No suitable objects in _lowPriorityRoutes list");
      }
    }

    return null;
  }

  TransportationResource getFirstSuitableTransportation(
          AirportPosition routeStartPosition,
          int planeSpaceAmount,
          List<TransportationResource> prioritizedList) =>
      prioritizedList.firstWhere(
          (element) =>
              element.startPoint.airportPosition == routeStartPosition &&
              didPlaneCanPickup(planeSpaceAmount, element.amount),
          orElse: () => prioritizedList.firstWhere((element) =>
              didPlaneCanPickup(planeSpaceAmount, element.amount)));

  AircraftRoute getAircraftRouteFromTransportationResource(
      TransportationResource transportation) {
    return AircraftRoute(
      name:
          "Route From${transportation.startPoint.name}to${transportation.endPoint.name}",
      startPoint: transportation.startPoint,
      endPoint: transportation.endPoint,
      routeProfit: transportation.costPerUnit * transportation.amount,
      routePriority: transportation.priority,
    );
  }

  void updateGeneratedRoutesScheme(
    List<AircraftRoute> currentRoutes,
    List<Aircraft> activePlanes,
  ) {}
}
