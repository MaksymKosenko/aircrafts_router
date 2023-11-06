import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

import 'models/aircraft.dart';
import 'models/aircraft_route.dart';

class AlgorithmUtil {
  AlgorithmUtil._privateConstructor();

  static final AlgorithmUtil _instance = AlgorithmUtil._privateConstructor();

  factory AlgorithmUtil() {
    return _instance;
  }

  late List<AircraftRoute> _generatedRoutes;

  List<AircraftRoute> get generatedRoutes => _generatedRoutes;

  set generatedRoutes(List<AircraftRoute> generatedRoutes) {
    _generatedRoutes = generatedRoutes;
  }

  void generateRoutesScheme(List<Airport> airports, List<AircraftRoute> routes,
      List<Aircraft> planes) {
    //TODO: implement some routes calculation
    //As for now, data is hardcoded
    generatedRoutes = routes;
  }

  void updateGeneratedRoutesScheme(
    List<AircraftRoute> currentRoutes,
    List<Aircraft> activePlanes,
  ) {}
}
