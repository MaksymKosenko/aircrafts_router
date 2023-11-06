import 'aircraft_route.dart';
import 'airport.dart';

class TransportationResource {
  TransportationResource({
    required this.startPoint,
    required this.endPoint,
    required this.amount,
    required this.costPerUnit,
    required this.priority,
  });

  ///Start location of the Resource
  final Airport startPoint;

  ///Destination location of the Resource
  final Airport endPoint;

  ///Space needed for transportation of the resource in nominal units
  final int amount;

  ///Cost of the resource per one unit
  final int costPerUnit;

  ///Priority of the transportation
  final Priority priority;
}
