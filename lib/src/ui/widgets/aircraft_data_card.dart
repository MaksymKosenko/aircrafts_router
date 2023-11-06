import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/ui/widgets/aircraft_data_editor.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';

class AircraftDataCard extends StatelessWidget {
  const AircraftDataCard({super.key, required this.aircraft});

  final Aircraft aircraft;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.borderRadius4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: AppDimensions.horizontalPadding8 +
                AppDimensions.verticalPadding8,
            child: Text(
              aircraft.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) {
                    return AircraftDataEditor(aircraft: aircraft);
                  });
            },
            child: const Text('Details'),
          ),
        ],
      ),
    );
  }
}
