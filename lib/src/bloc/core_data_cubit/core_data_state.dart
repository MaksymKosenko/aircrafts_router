part of 'core_data_cubit.dart';

class CoreDataState {
  CoreDataState({
    required this.airports,
    required this.aircrafts,
    required this.transportationResources,
    required this.isActiveAlgorithmMode,
  });

  List<Airport> airports;
  List<Aircraft> aircrafts;
  List<TransportationResource> transportationResources;
  bool isActiveAlgorithmMode;

  CoreDataState copyWith({
    List<Airport>? airports,
    List<Aircraft>? aircrafts,
    List<TransportationResource>? transportationResources,
    bool? isActiveAlgorithmMode,
  }) {
    return CoreDataState(
        airports: airports ?? this.airports,
        aircrafts: aircrafts ?? this.aircrafts,
        transportationResources:
            transportationResources ?? this.transportationResources,
        isActiveAlgorithmMode:
            isActiveAlgorithmMode ?? this.isActiveAlgorithmMode);
  }
}
