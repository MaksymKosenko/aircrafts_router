import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:aircrafts_router/src/bloc/selected_item_cubit/selected_item_cubit.dart';
import 'package:aircrafts_router/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedItemWidget extends StatefulWidget {
  const SelectedItemWidget({Key? key}) : super(key: key);

  @override
  State<SelectedItemWidget> createState() => _SelectedItemWidgetState();
}

class _SelectedItemWidgetState extends State<SelectedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SelectedItemState>(
      stream: context.read<SelectedItemCubit>().selectedItemsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final selectedState = snapshot.data!;

          if (selectedState.aircraft != null) {
            return _buildAircraftDataListView(selectedState.aircraft!);
          } else if (selectedState.airport != null) {
            return _buildAirportDataListView(selectedState.airport!);
          }
        }
        return SizedBox();
      },
    );

    /*
        BlocBuilder<SelectedItemCubit, SelectedItemState>(
        builder: (context, state) {
      if (state.airport != null) {
        return _buildAirportDataListView(state.airport!);
      } else if (state.aircraft != null) {
        return _buildAircraftDataListView(state.aircraft!);
      }
      return const SizedBox();
    });
         */
  }

  Widget _buildAircraftDataListView(Aircraft aircraft) {
    return ListView(
      itemExtent: 100,
      children: [
        Text('Aircraft Name: ${aircraft.name}'),
        Text('Fuel Amount: ${aircraft.fuelAmount}'),
        Text('Max Fuel Amount: ${aircraft.maxFuelAmount}'),
        Text('Flight State: ${Constants.flightStates[aircraft.flightState]}'),
        aircraft.flightState == AircraftFlightState.flying
            ? Text('Path complete: ${aircraft.currentPosition * 100}%')
            : const SizedBox(),
        Text(
            'Technical State: ${Constants.aircraftTechnicalStates[aircraft.aircraftTechnicalState]}'),
      ],
    );
  }

  Widget _buildAirportDataListView(Airport airport) {
    return ListView(
      itemExtent: 20,
      children: [
        Text('Airport Name: ${airport.name}'),
        Text('Fuel Amount: ${airport.fuelAmount}'),
        Text('Current Aircraft Amount: ${airport.currentAircraftAmount}'),
        Text('Total Aircraft Amount: ${airport.totalAircraftAmount}'),
      ],
    );
  }
}
