part of 'core_data_cubit.dart';

class CoreDataState {
  CoreDataState({
    required this.airports,
    required this.aircrafts,
    required this.transportationResources,
  });

  List<Airport> airports;
  List<Aircraft> aircrafts;
  List<TransportationResource> transportationResources;

  CoreDataState copyWith({
    List<Airport>? airports,
    List<Aircraft>? aircrafts,
    List<TransportationResource>? transportationResources,
  }) {
    return CoreDataState(
      airports: airports ?? this.airports,
      aircrafts: aircrafts ?? this.aircrafts,
      transportationResources: transportationResources ?? this.transportationResources,
    );
  }
}
