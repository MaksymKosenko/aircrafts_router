part of 'algorithm_cubit.dart';

class AlgorithmState {
  final List<AircraftRoute> generatedRoutes;
  final List<Aircraft> aircrafts;
  final List<Airport> airports;
  final List<TransportationResource> criticalPriorityRoutes;
  final List<TransportationResource> highPriorityRoutes;
  final List<TransportationResource> midPriorityRoutes;
  final List<TransportationResource> lowPriorityRoutes;

  AlgorithmState({
    List<AircraftRoute>? generatedRoutes,
    List<Aircraft>? aircrafts,
    List<Airport>? airports,
    List<TransportationResource>? criticalPriorityRoutes,
    List<TransportationResource>? highPriorityRoutes,
    List<TransportationResource>? midPriorityRoutes,
    List<TransportationResource>? lowPriorityRoutes,
  })  : generatedRoutes = generatedRoutes ?? [],
        aircrafts = aircrafts ?? [],
        airports = airports ?? [],
        criticalPriorityRoutes = criticalPriorityRoutes ?? [],
        highPriorityRoutes = highPriorityRoutes ?? [],
        midPriorityRoutes = midPriorityRoutes ?? [],
        lowPriorityRoutes = lowPriorityRoutes ?? [];

  AlgorithmState copyWith({
    List<AircraftRoute>? generatedRoutes,
    List<Aircraft>? aircrafts,
    List<Airport>? airports,
    List<TransportationResource>? criticalPriorityRoutes,
    List<TransportationResource>? highPriorityRoutes,
    List<TransportationResource>? midPriorityRoutes,
    List<TransportationResource>? lowPriorityRoutes,
  }) {
    return AlgorithmState(
      generatedRoutes: generatedRoutes ?? this.generatedRoutes,
      aircrafts: aircrafts ?? this.aircrafts,
      airports: airports ?? this.airports,
      criticalPriorityRoutes:
          criticalPriorityRoutes ?? this.criticalPriorityRoutes,
      highPriorityRoutes: highPriorityRoutes ?? this.highPriorityRoutes,
      midPriorityRoutes: midPriorityRoutes ?? this.midPriorityRoutes,
      lowPriorityRoutes: lowPriorityRoutes ?? this.lowPriorityRoutes,
    );
  }
}
