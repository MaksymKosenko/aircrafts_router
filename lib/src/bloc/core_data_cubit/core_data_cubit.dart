import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:aircrafts_router/src/algorithm_util/models/transportation_resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'core_data_state.dart';

class CoreDataCubit extends Cubit<CoreDataState> {
  CoreDataCubit({
    required List<Airport> airports,
    required List<Aircraft> aircrafts,
    required List<TransportationResource> transportationRecourses,
  }) : super(CoreDataState(
          airports: airports,
          aircrafts: aircrafts,
          transportationResources: transportationRecourses,
        ));
}
