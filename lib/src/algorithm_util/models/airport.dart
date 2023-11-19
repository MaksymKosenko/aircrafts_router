import 'dart:ui';

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
  final AirportPosition airportPosition;

  ///Fuel amount in liters
  double fuelAmount;

  ///Amount of Aircraft that can be on the Airport in one time
  int totalAircraftAmount;

  ///Amount of Aircraft that currently at the Airport
  int currentAircraftAmount = 0;
}

///Represent x and y position on scale.
///Where top left position is (0;0)
///And bottom right position is (10;10)
class AirportPosition {
  final int _x;
  final int _y;

  const AirportPosition(int x, int y)
      : assert(x >= 0 && x <= 30),
        assert(y >= 0 && y <= 12),
        _x = x,
        _y = y;

  Offset get position => Offset(_x.toDouble(), _y.toDouble()) * 50;
}
