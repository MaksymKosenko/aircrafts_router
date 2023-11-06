import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:aircrafts_router/src/bloc/aircraft_data_cubit/aircraft_data_cubit.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';
import 'package:aircrafts_router/src/ui/widgets/digits_input_field.dart';
import 'package:aircrafts_router/src/ui/widgets/route_data_widget.dart';

class AircraftDataEditor extends StatefulWidget {
  const AircraftDataEditor({Key? key, required this.aircraft})
      : super(key: key);

  final Aircraft aircraft;

  @override
  State<AircraftDataEditor> createState() => _AircraftDataEditorState();
}

class _AircraftDataEditorState extends State<AircraftDataEditor> {
  static const Map<AircraftTechnicalState, String> aircraftTechnicalStates = {
    AircraftTechnicalState.excellent: 'Excellent',
    AircraftTechnicalState.good: 'Good',
    AircraftTechnicalState.fine: 'Fine',
    AircraftTechnicalState.bad: 'Bad',
    AircraftTechnicalState.critical: 'Critical',
  };

  Priority? selectedRoutePriority;
  late TextEditingController routeProfitController;
  late TextEditingController aircraftCostController;
  late TextEditingController transportationResourceCostController;
  late TextEditingController transportationSpaceAmountController;
  late AircraftDataCubit aircraftCubit;

  @override
  void initState() {
    super.initState();
    selectedRoutePriority = widget.aircraft.aircraftRoutes.first.routePriority;
    routeProfitController = TextEditingController(
        text: widget.aircraft.aircraftRoutes.first.routeProfit.toString());
    aircraftCostController =
        TextEditingController(text: widget.aircraft.aircraftCost.toString());
    transportationResourceCostController = TextEditingController(
        text: widget.aircraft.transportationResourceCost.toString());
    transportationSpaceAmountController = TextEditingController(
        text: widget.aircraft.transportSpaceAmount.toString());
    aircraftCubit = AircraftDataCubit(aircraft: widget.aircraft);
  }

  @override
  void dispose() {
    routeProfitController.dispose();
    aircraftCostController.dispose();
    transportationResourceCostController.dispose();
    transportationSpaceAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.size(context).height * 0.9,
      width: AppDimensions.size(context).width,
      margin:
          AppDimensions.horizontalPadding16 + AppDimensions.verticalPadding16,
      child: ListView(
        children: [
          Text('Aircraft name: ${widget.aircraft.name}'),
          const Text('Aircraft routes:'),
          for (var route in widget.aircraft.aircraftRoutes)
            RouteDataWidget(aircraftRoute: route),
          Row(
            children: [
              const Text('Aircraft technical state:   '),
              DropdownButton<AircraftTechnicalState>(
                value: widget.aircraft.aircraftTechnicalState,
                items: AircraftTechnicalState.values.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(aircraftTechnicalStates[state]!),
                  );
                }).toList(),
                onChanged: (state) {
                  setState(() {
                    aircraftCubit.changeAircraftTechnicalState(state);
                  });
                },
              ),
            ],
          ),
          Text('Max fuel amount: ${widget.aircraft.maxFuelAmount}'),
          Row(
            children: [
              const Text('Aircraft cost: '),
              DigitsInputField(
                controller: aircraftCostController,
                onChanged: aircraftCubit.changeAircraftCost,
              ),
            ],
          ),
          Row(
            children: [
              const Text('Transportation resource cost: '),
              DigitsInputField(
                controller: transportationResourceCostController,
                onChanged: aircraftCubit.changeTransportationResourceCost,
              ),
            ],
          ),
          Row(
            children: [
              const Text('Aircraft Space Amount: '),
              DigitsInputField(
                controller: transportationSpaceAmountController,
                onChanged: aircraftCubit.changeTransportSpaceAmount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
