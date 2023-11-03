import 'dart:math';
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
  Offset get currentPosition {
    return context
        .read<AircraftFlightSimulationCubit>()
        .getDisplayAircraftPosition(widget.aircraft);
  }

  Offset get airportPosition {
    return widget
        .aircraft.aircraftRoutes.first.endPoint.airportPosition.position;
  }

  double get rotationAngle => _calculateRotationAngle(airportPosition);

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
            child: const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.airplanemode_active,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateRotationAngle(Offset target) {
    double radians = atan2(target.dy, target.dx);
    double degrees = radians * 180 / pi;

    return degrees;
  }
}
