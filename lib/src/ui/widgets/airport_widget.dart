import 'package:aircrafts_router/src/bloc/selected_item_cubit/selected_item_cubit.dart';
import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: GestureDetector(
        onTap: () =>
            context.read<SelectedItemCubit>().selectAirport(widget.airport),
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
      ),
    );
  }
}
