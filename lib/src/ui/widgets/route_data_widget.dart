import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:aircrafts_router/src/bloc/route_cubit/route_cubit.dart';
import 'package:aircrafts_router/src/ui/widgets/digits_input_field.dart';

class RouteDataWidget extends StatefulWidget {
  const RouteDataWidget({Key? key, required this.aircraftRoute})
      : super(key: key);

  final AircraftRoute aircraftRoute;

  @override
  State<RouteDataWidget> createState() => _RouteDataWidgetState();
}

class _RouteDataWidgetState extends State<RouteDataWidget> {
  static const routePriorityMap = {
    RoutePriority.critical: 'Critical',
    RoutePriority.high: 'High',
    RoutePriority.mid: 'Mid',
    RoutePriority.low: 'Low',
  };

  static const emergencySituation = {
    EmergencySituationOnTheRouter.transportationObjectIssue:
        'Transportation Object Issue',
    EmergencySituationOnTheRouter.badWeather: 'Bad Weather',
    EmergencySituationOnTheRouter.aircraftBreakdown: 'Aircraft Breakdown',
    EmergencySituationOnTheRouter.none: 'None',
  };

  late TextEditingController routeProfitController;
  late RouteCubit routeCubit;

  @override
  void initState() {
    super.initState();
    routeProfitController = TextEditingController(
        text: widget.aircraftRoute.routeProfit.toString());
    routeCubit = RouteCubit(route: widget.aircraftRoute);
  }

  @override
  void dispose() {
    routeProfitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Route name: ${routeCubit.route.name}'),
        Text('Start Point: ${routeCubit.route.startPoint.name}'),
        Text('End Point: ${routeCubit.route.endPoint.name}'),
        Text(
            'Transition Point: ${routeCubit.route.transitionPoint?.name ?? 'N/A'}'),
        Row(
          children: [
            const Text('Route Profit: '),
            DigitsInputField(
              controller: routeProfitController,
              onChanged: routeCubit.changeRouteProfit,
            ),
          ],
        ),
        Row(
          children: [
            const Text('Route Priority: '),
            DropdownButton<RoutePriority>(
              value: routeCubit.route.routePriority,
              items: RoutePriority.values.map((priority) {
                return DropdownMenuItem(
                  value: priority,
                  child: Text(routePriorityMap[priority] ?? ''),
                );
              }).toList(),
              onChanged: (priority) {
                setState(() {
                  routeCubit.changeRoutePriority(priority);
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Emergency Situation: '),
            DropdownButton<EmergencySituationOnTheRouter>(
              value: routeCubit.route.emergencySituationOnTheRouter,
              items: EmergencySituationOnTheRouter.values.map((situation) {
                return DropdownMenuItem(
                  value: situation,
                  child: Text(emergencySituation[situation] ?? 'N/A'),
                );
              }).toList(),
              onChanged: (situation) {
                setState(() {
                  routeCubit.changeEmergencySituationOnTheRoute(situation);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
