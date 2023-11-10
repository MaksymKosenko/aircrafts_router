import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/ui/widgets/selected_item_widget.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:aircrafts_router/src/bloc/aircraft_flight_simulation_cubit/aircraft_flight_simulation_cubit.dart';
import 'package:aircrafts_router/src/bloc/core_data_cubit/core_data_cubit.dart';
import 'package:aircrafts_router/src/ui/widgets/aircraft_widget.dart';
import 'package:aircrafts_router/src/ui/widgets/airport_widget.dart';
import 'package:aircrafts_router/src/settings/settings_view.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  late final CoreDataCubit coreDataCubit;
  late final AircraftFlightSimulationCubit flightSimulationCubit;

  Airport? selectedAirport;
  Aircraft? selectedAircraft;

  @override
  void initState() {
    super.initState();
    coreDataCubit = context.read<CoreDataCubit>();
    flightSimulationCubit = context.read<AircraftFlightSimulationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          _buildPlayButton(),
          _buildStopButton(),
          _buildRestartButton(),
          _buildSettingsButton(),
        ],
      ),
      body: Padding(
        padding: AppDimensions.horizontalPadding24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<AircraftFlightSimulationCubit,
                AircraftFlightSimulationState>(
              builder: (context, state) {
                return _buildAircraftsAndAirports(state.aircraftList);
              },
            ),
            SizedBox(
              width: AppDimensions.size(context).width * 0.3,
              child: const SelectedItemWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return BlocBuilder<AircraftFlightSimulationCubit,
        AircraftFlightSimulationState>(
      builder: (context, state) {
        if (state.isRunningSimulation) {
          return const SizedBox();
        }
        return IconButton(
          onPressed: () {
            if (state.isRunningSimulation) return;
            flightSimulationCubit.startSimulation();
          },
          icon: const Icon(Icons.play_arrow),
        );
      },
    );
  }

  Widget _buildStopButton() {
    return BlocBuilder<AircraftFlightSimulationCubit,
        AircraftFlightSimulationState>(
      builder: (context, state) {
        if (state.isRunningSimulation) {
          return IconButton(
            onPressed: () {
              flightSimulationCubit.stopSimulation();
            },
            icon: const Icon(Icons.stop_circle_outlined),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildRestartButton() {
    return IconButton(
      onPressed: () {
        flightSimulationCubit.restartSimulation();
      },
      icon: const Icon(Icons.restore_rounded),
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.restorablePushNamed(context, SettingsView.routeName);
      },
    );
  }

  Widget _buildAircraftsAndAirports(List<Aircraft> aircrafts) {
    return SizedBox(
      width: AppDimensions.size(context).width * 0.5,
      child: Stack(
        children: [
          for (Airport airport in coreDataCubit.state.airports)
            AirportWidget(airport: airport),
          for (Aircraft aircraft in _getActiveAircrafts(aircrafts))
            AircraftWidget(aircraft: aircraft),
        ],
      ),
    );
  }

  List<Aircraft> _getActiveAircrafts(List<Aircraft> aircrafts) {
    return aircrafts
        .where(
            (aircraft) => aircraft.flightState != AircraftFlightState.completed)
        .toList();
  }
}
