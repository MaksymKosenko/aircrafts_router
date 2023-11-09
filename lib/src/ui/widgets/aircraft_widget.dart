import 'dart:async';
import 'dart:math' as math;
import 'package:aircrafts_router/src/algorithm_util/algorithm_util.dart';
import 'package:aircrafts_router/src/bloc/selected_item_cubit/selected_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/bloc/aircraft_flight_simulation_cubit/aircraft_flight_simulation_cubit.dart';

import '../../algorithm_util/models/aircraft_route.dart';

class AircraftWidget extends StatefulWidget {
  const AircraftWidget({Key? key, required this.aircraft}) : super(key: key);

  final Aircraft aircraft;

  @override
  State<AircraftWidget> createState() => _AircraftWidgetState();
}

class _AircraftWidgetState extends State<AircraftWidget> {
  late final AircraftFlightSimulationCubit flightCubit =
      context.read<AircraftFlightSimulationCubit>();

  bool isListening = true;


  Offset get currentPosition =>
      flightCubit.getDisplayAircraftPosition(widget.aircraft, startPosition, targetPosition);

  Offset get startPosition {
    Offset start =
        widget.aircraft.aircraftRoutes.first.startPoint.airportPosition.position;
    if (widget.aircraft.aircraftRoutes.first.transitionPoint != null && widget.aircraft.isReachedTransitionPoint) {
      start = widget.aircraft.aircraftRoutes.first.transitionPoint!.airportPosition.position;
    }
    return start;
  }

  Offset get targetPosition {
    Offset target =
        widget.aircraft.aircraftRoutes.first.endPoint.airportPosition.position;
    if (widget.aircraft.aircraftRoutes.first.transitionPoint != null && !widget.aircraft.isReachedTransitionPoint) {
      target = widget.aircraft.aircraftRoutes.first.transitionPoint!.airportPosition.position;
    }
    return target;
  }

  double get rotationAngle => calculateRotationAngle();

  double calculateRotationAngle() {
    final dx = targetPosition.dx - currentPosition.dx;
    final dy = currentPosition.dy - targetPosition.dy;
    double angle = math.atan2(dy, dx);
    angle = -angle + math.pi / 2;
    return angle < 0 ? angle + 2 * math.pi : angle;
  }

  @override
  void initState() {
    super.initState();
    addListener();
  }

  void addListener() {
    flightCubit.stream.listen((state) {
      if (isListening &&
          state.aircraftList.any((aircraft) =>
              aircraft == widget.aircraft &&
              aircraft.aircraftRoutes.first.endPoint.airportPosition.position ==
                  currentPosition)) {

        print('${widget.aircraft.name} Finished');
        //TODO implement correctly
        //Here should be nullifying of the aircraft
        AircraftRoute? nextRoute = AlgorithmUtil().getNextRoute(widget.aircraft);
        if(nextRoute != null) {
          widget.aircraft.aircraftRoutes.add(nextRoute);
        }
        //isListening = false;
      }
    });
  }

  @override
  void dispose() {
    flightCubit.stream.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: currentPosition.dx,
      top: currentPosition.dy,
      child: Column(
        children: [
          Text(widget.aircraft.name),
          Transform.rotate(
            angle: rotationAngle,
            child: IconButton(
              onPressed: () => context
                  .read<SelectedItemCubit>()
                  .selectAircraft(widget.aircraft),
              icon: const Icon(
                Icons.airplanemode_active,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
