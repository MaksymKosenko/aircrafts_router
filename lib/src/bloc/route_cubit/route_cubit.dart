import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteCubit extends Cubit<AircraftRoute> {
  RouteCubit({required this.route}) : super(route);

  final AircraftRoute route;

  void changeRouteProfit(String profit) {
    route.routeProfit = int.parse(profit);
  }

  void changeRoutePriority(RoutePriority? priority) {
    if (priority == null) return;
    route.routePriority = priority;
  }

  void changeEmergencySituationOnTheRoute(
      EmergencySituationOnTheRouter? situation) {
    if (situation == null) return;

    route.emergencySituationOnTheRouter = situation;
  }
}
