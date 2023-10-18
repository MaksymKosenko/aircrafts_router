import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

import 'models/aircraft.dart';
import 'models/aircraft_route.dart';

class AlgorithmUtil {
  AlgorithmUtil._privateConstructor();

  static final AlgorithmUtil _instance = AlgorithmUtil._privateConstructor();

  factory AlgorithmUtil() {
    return _instance;
  }

  late Map<AircraftRoute, Aircraft> _generatedRoutes;

  Map<AircraftRoute, Aircraft> get generatedRoutes => _generatedRoutes;

  set generatedRoutes(Map<AircraftRoute, Aircraft> generatedRoutes) {
    _generatedRoutes = generatedRoutes;
  }

  void generateRoutesScheme(List<Airport> airports, List<AircraftRoute> routes,
      List<Aircraft> planes) {
    //TODO: implement some routes calculation
    //As for now, data is hardcoded
    generatedRoutes = <AircraftRoute, Aircraft>{
      routes[1]: planes[0],
      routes[2]: planes[0],
      routes[0]: planes[1],
      routes[3]: planes[1],
    };
  }

  void updateGeneratedRoutesScheme(
    List<AircraftRoute> currentRoutes,
    List<Aircraft> activePlanes,
  ) {}
}
