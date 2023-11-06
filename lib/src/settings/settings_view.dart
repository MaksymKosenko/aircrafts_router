import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aircrafts_router/src/bloc/core_data_cubit/core_data_cubit.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';
import 'package:aircrafts_router/src/ui/widgets/aircraft_data_card.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          _buildThemeDropdown(),
        ],
      ),
      body: BlocBuilder<CoreDataCubit, CoreDataState>(
        builder: (context, state) {
          return _buildAircraftList(state, context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle create aircraft action
        },
        child: const Text('Create Aircraft'),
      ),
    );
  }

  Widget _buildThemeDropdown() {
    return DropdownButton<ThemeMode>(
      value: controller.themeMode,
      onChanged: controller.updateThemeMode,
      items: const [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text('System Theme'),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text('Light Theme'),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text('Dark Theme'),
        ),
      ],
    );
  }

  Widget _buildAircraftList(CoreDataState state, BuildContext context) {
    if (state.aircrafts.isEmpty) {
      return const Center(
        child: Text('No airplanes!'),
      );
    }
    return ListView.builder(
      itemCount: state.aircrafts.length,
      itemExtent: AppDimensions.size(context).height * 0.15,
      itemBuilder: (context, index) {
        return AircraftDataCard(aircraft: state.aircrafts[index]);
      },
    );
  }
}
