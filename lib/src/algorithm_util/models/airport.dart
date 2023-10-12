class Airport {
  Airport({
    required this.name,
    required this.airportPosition,
    required this.fuelAmount,
    required this.totalAircraftAmount,
  });

  ///Airport name
  final String name;

  ///Airport position on a flat surface (x, y)
  AirportPosition airportPosition;

  ///Fuel amount in liters
  double fuelAmount;

  ///Amount of Aircraft that can be on the Airport in one time
  int totalAircraftAmount;

  ///Amount of Aircraft that currently at the Airport
  int currentAircraftAmount = 0;
}

class AirportPosition {
  const AirportPosition(this.x, this.y);

  final int x;
  final int y;
}
