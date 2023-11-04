import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/bloc/aircraft_flight_simulation_cubit/aircraft_flight_simulation_cubit.dart';

class AircraftWidget extends StatefulWidget {
  final Aircraft aircraft;

  const AircraftWidget({Key? key, required this.aircraft}) : super(key: key);

  @override
  State<AircraftWidget> createState() => _AircraftWidgetState();
}

class _AircraftWidgetState extends State<AircraftWidget> {
  late Offset currentPosition;
  late Offset airportPosition;
  late double rotationAngle;

  @override
  void initState() {
    super.initState();
    currentPosition = context
        .read<AircraftFlightSimulationCubit>()
        .getDisplayAircraftPosition(widget.aircraft);
    airportPosition =
        widget.aircraft.aircraftRoutes.first.endPoint.airportPosition.position;
    rotationAngle = calculateRotationAngle();
  }

  double calculateRotationAngle() {
    final dx = airportPosition.dx - currentPosition.dx;
    final dy = currentPosition.dy - airportPosition.dy;

    double angle = math.atan2(dy, dx);
    angle = -angle + math.pi / 2;

    return angle < 0 ? angle + 2 * math.pi : angle;
  }

  Widget build(BuildContext context) {
    return Positioned(
      left: currentPosition.dx,
      top: currentPosition.dy,
      child: Column(
        children: [
          buildAircraftName(),
          buildRotatedAircraftIcon(),
        ],
      ),
    );
  }

  Widget buildAircraftName() {
    return Text(widget.aircraft.name);
  }

  Widget buildRotatedAircraftIcon() {
    return Transform.rotate(
      angle: rotationAngle,
      child: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.airplanemode_active,
        ),
      ),
    );
  }
}
