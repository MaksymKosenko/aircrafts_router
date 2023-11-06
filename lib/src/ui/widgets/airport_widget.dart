import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';

class AirportWidget extends StatefulWidget {
  const AirportWidget({Key? key, required this.airport}) : super(key: key);

  final Airport airport;

  @override
  State<AirportWidget> createState() => _AirportWidgetState();
}

class _AirportWidgetState extends State<AirportWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.airport.airportPosition.position.dx,
      top: widget.airport.airportPosition.position.dy,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: Center(
          child: Text(widget.airport.name),
        ),
      ),
    );
  }
}
