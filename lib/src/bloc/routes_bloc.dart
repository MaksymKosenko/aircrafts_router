import 'package:aircrafts_router/src/algorithm_util/algorithm_util.dart';

import '../algorithm_util/models/aircraft.dart';
import '../algorithm_util/models/aircraft_route.dart';

class RoutesBloc {
  RoutesBloc();

  final List<AircraftRoute> allRoutes = [];
  final List<AircraftRoute> currentRoutes = [];

  final List<Aircraft> allPlanes = [];
  final List<Aircraft> activePlanes = [];

  void addRouteToAllRoutes(AircraftRoute route) {
    allRoutes.add(route);
  }

  void addRouteToCurrentRoutes(AircraftRoute route) {
    currentRoutes.add(route);
  }

  void setAllRoutes(List<AircraftRoute> routes) {
    routes.forEach((element) => allRoutes.add(element));
  }

  void setCurrentRoutes(List<AircraftRoute> routes) {
    routes.forEach((element) => currentRoutes.add(element));
  }

  void removeRouteFromAllRoutes(AircraftRoute route) {
    allRoutes.remove(route);
  }

  void removeRouteFromCurrentRoutes(AircraftRoute route) {
    currentRoutes.remove(route);
  }

  //TODO: implement rebuilding of routes in case of bad weather, aircraft issue, etc.
  void rebuildRoutes() {
    AlgorithmUtil().updateGeneratedRoutesScheme(currentRoutes, activePlanes);
  }
}
