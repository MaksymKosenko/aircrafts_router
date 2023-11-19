import 'package:aircrafts_router/src/algorithm_util/algorithm_util.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:aircrafts_router/src/algorithm_util/models/transportation_resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'algorithm_state.dart';

class AlgorithmCubit extends Cubit<AlgorithmState> {
  AlgorithmCubit({
    required List<Airport> airports,
    required List<TransportationResource> transportationResources,
    required List<Aircraft> aircrafts,
    required bool isActiveAlgorithmMode,
  }) : super(AlgorithmState()) {
    isActiveAlgorithmMode
        ? generateStartRoutes(
            airports: airports,
            transportationResources: transportationResources,
            aircrafts: aircrafts,
          )
        : generateStartRoutesWithoutAlgorithm(
            airports: airports,
            transportationResources: transportationResources,
            aircrafts: aircrafts);
  }

  final AlgorithmUtil algorithmUtil = AlgorithmUtil();

  void generateStartRoutes({
    required List<Airport> airports,
    required List<TransportationResource> transportationResources,
    required List<Aircraft> aircrafts,
  }) {
    algorithmUtil.generateStartRoutes(
      airports,
      transportationResources,
      aircrafts,
    );

    emit(state.copyWith(airports: airports, aircrafts: aircrafts));
  }

  void generateStartRoutesWithoutAlgorithm({
    required List<Airport> airports,
    required List<TransportationResource> transportationResources,
    required List<Aircraft> aircrafts,
  }) {
    algorithmUtil.generateStartRoutesWithoutAlgorithm(
      airports,
      transportationResources,
      aircrafts,
    );

    emit(state.copyWith(airports: airports, aircrafts: aircrafts));
  }
}
