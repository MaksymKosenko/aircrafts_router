import 'dart:math' as math;
import 'package:aircrafts_router/src/bloc/selected_item_cubit/selected_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/bloc/aircraft_flight_simulation_cubit/aircraft_flight_simulation_cubit.dart';

class AircraftWidget extends StatefulWidget {
  const AircraftWidget({Key? key, required this.aircraft}) : super(key: key);

  final Aircraft aircraft;

  @override
  State<AircraftWidget> createState() => _AircraftWidgetState();
}

class _AircraftWidgetState extends State<AircraftWidget> {
  late final AircraftFlightSimulationCubit flightCubit =
      context.read<AircraftFlightSimulationCubit>();

  Offset get currentPosition => flightCubit.getDisplayAircraftPosition(
      widget.aircraft, startPosition, targetPosition);

  Offset get startPosition {
    if (widget.aircraft.aircraftRoutes.isEmpty) {
      return widget.aircraft.baseAircraftPosition.airportPosition.position;
    }

    Offset start = widget
        .aircraft.aircraftRoutes.first.startPoint.airportPosition.position;
    if (widget.aircraft.aircraftRoutes.first.transitionPoint != null &&
        widget.aircraft.isReachedTransitionPoint) {
      start = widget.aircraft.aircraftRoutes.first.transitionPoint!
          .airportPosition.position;
    }

    if (widget.aircraft.aircraftRoutes.first.startPoint !=
        widget.aircraft.baseAircraftPosition) {
      start = widget.aircraft.baseAircraftPosition.airportPosition.position;
    }

    return start;
  }

  Offset get targetPosition {
    if (widget.aircraft.aircraftRoutes.isEmpty) {
      return Offset.zero;
    }

    Offset target =
        widget.aircraft.aircraftRoutes.first.endPoint.airportPosition.position;
    if (widget.aircraft.aircraftRoutes.first.transitionPoint != null &&
        !widget.aircraft.isReachedTransitionPoint) {
      target = widget.aircraft.aircraftRoutes.first.transitionPoint!
          .airportPosition.position;
    }

    if (widget.aircraft.aircraftRoutes.first.startPoint !=
        widget.aircraft.baseAircraftPosition) {
      target = widget
          .aircraft.aircraftRoutes.first.startPoint.airportPosition.position;
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
  Widget build(BuildContext context) {
    return Positioned(
      left: currentPosition.dx,
      top: currentPosition.dy,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                color: Colors.yellow,
                shadows: [Shadow(blurRadius: 2)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
