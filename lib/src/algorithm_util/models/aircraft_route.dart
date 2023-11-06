import 'airport.dart';

class AircraftRoute {
  AircraftRoute({
    required this.name,
    required this.startPoint,
    this.transitionPoint,
    required this.endPoint,
    required this.routeProfit,
    required this.routePriority,
  }) : emergencySituationOnTheRouter = EmergencySituationOnTheRouter.none;

  ///AircraftRoute name
  final String name;

  ///Base location of the Aircraft
  final Airport startPoint;

  ///Destination location of the Aircraft
  final Airport endPoint;

  ///Transit point or extra lending place of the Aircraft
  Airport? transitionPoint;

  ///Profit of the Route
  int routeProfit;

  ///Route priority over the other Routes
  RoutePriority routePriority;

  ///Emergency Situation that may be the reason of Route change
  EmergencySituationOnTheRouter emergencySituationOnTheRouter;
}

enum RoutePriority {
  low,
  mid,
  high,
  critical,
}

enum EmergencySituationOnTheRouter {
  none,
  badWeather,
  aircraftBreakdown,
  transportationObjectIssue,
}
