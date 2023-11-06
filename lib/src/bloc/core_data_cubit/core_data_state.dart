part of 'core_data_cubit.dart';

class CoreDataState {
  CoreDataState({
    required this.airports,
    required this.aircrafts,
    required this.aircraftRoutes,
  });

  List<Airport> airports;
  List<Aircraft> aircrafts;
  List<AircraftRoute> aircraftRoutes;

  CoreDataState copyWith({
    List<Airport>? airports,
    List<Aircraft>? aircrafts,
    List<AircraftRoute>? aircraftRoutes,
  }) {
    return CoreDataState(
      airports: airports ?? this.airports,
      aircrafts: aircrafts ?? this.aircrafts,
      aircraftRoutes: aircraftRoutes ?? this.aircraftRoutes,
    );
  }
}
