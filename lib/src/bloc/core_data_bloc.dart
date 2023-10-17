import 'package:aircrafts_router/src/bloc/bloc.dart';

import '../algorithm_util/models/aircraft.dart';
import '../algorithm_util/models/airport.dart';
import '../algorithm_util/models/route.dart';
import '../algorithm_util/algorithm_util.dart';

class CoreDataBloc extends Bloc{
  CoreDataBloc(this.airports, this.routes, this.planes){
    AlgorithmUtil().generateRoutesScheme();
  }

  final List<Airport> airports;
  final List<AircraftRoute> routes;
  final List<Aircraft> planes;

  //TODO implement statistic features
}