import 'package:flutter/material.dart';

import 'package:aircrafts_router/src/bloc/aircraft_cubit/aircraft_cubit.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';
import 'package:aircrafts_router/src/ui/widgets/digits_input_field.dart';
import 'package:aircrafts_router/src/ui/widgets/route_data.dart';
import '../../algorithm_util/models/aircraft.dart';
import '../../algorithm_util/models/aircraft_route.dart';

class AircraftDataEditor extends StatefulWidget {
  const AircraftDataEditor({super.key, required this.aircraft});

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

  RoutePriority? selectedRoutePriority;
  TextEditingController routeProfitController = TextEditingController();
  TextEditingController aircraftCostController = TextEditingController();
  TextEditingController transportationResourceCostController =
      TextEditingController();
  TextEditingController transportationSpaceAmountController =
      TextEditingController();

  late AircraftCubit aircraftCubit = AircraftCubit(aircraft: widget.aircraft);

  @override
  void initState() {
    super.initState();
    selectedRoutePriority = widget.aircraft.aircraftRoutes.first.routePriority;
    routeProfitController.text =
        widget.aircraft.aircraftRoutes.first.routeProfit.toString();

    aircraftCostController.text = widget.aircraft.aircraftCost.toString();

    transportationResourceCostController.text =
        widget.aircraft.transportationResourceCost.toString();

    transportationSpaceAmountController.text =
        widget.aircraft.transportSpaceAmount.toString();
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
            RouteData(aircraftRoute: route),
          Row(
            children: [
              const Text('Aircraft technical state:   '),
              DropdownButton<AircraftTechnicalState>(
                value: widget.aircraft.aircraftTechnicalState,
                items: AircraftTechnicalState.values
                    .map((state) => DropdownMenuItem(
                          value: state,
                          child: Text(aircraftTechnicalStates[state]!),
                        ))
                    .toList(),
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
