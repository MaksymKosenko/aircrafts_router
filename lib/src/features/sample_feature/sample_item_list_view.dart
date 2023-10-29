import 'dart:async';

import 'package:aircrafts_router/src/algorithm_util/models/aircraft.dart';
import 'package:aircrafts_router/src/algorithm_util/models/airport.dart';
import 'package:aircrafts_router/src/algorithm_util/models/aircraft_route.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  final List<Airport> items = [
    Airport(
        name: "A",
        airportPosition: const AirportPosition(3, 1),
        fuelAmount: 40,
        totalAircraftAmount: 3),
    Airport(
        name: "B",
        airportPosition: const AirportPosition(10, 6), //10; 6
        fuelAmount: 40,
        totalAircraftAmount: 3),
    Airport(
        name: "C",
        airportPosition: const AirportPosition(1, 7),
        fuelAmount: 40,
        totalAircraftAmount: 3),
    Airport(
        name: "D",
        airportPosition: const AirportPosition(5, 5),
        fuelAmount: 40,
        totalAircraftAmount: 3),
    Airport(
        name: "E",
        airportPosition: const AirportPosition(6, 2), //6; 2
        fuelAmount: 40,
        totalAircraftAmount: 3),
  ];

  late final List<AircraftRoute> routes;
  late final List<Aircraft> aircrafts;

  @override
  void initState() {
    routes = [
      AircraftRoute(
        name: 'Route1',
        startPoint: items[0],
        endPoint: items[2],
        routeProfit: 100,
        routePriority: RoutePriority.low,
      ),
      AircraftRoute(
        name: 'Route2',
        startPoint: items[1],
        //1 = b
        endPoint: items[4],
        //4 = e
        routeProfit: 130,
        routePriority: RoutePriority.mid,
      ),
      AircraftRoute(
        name: 'Route3',
        startPoint: items[4],
        endPoint: items[1],
        routeProfit: 230,
        routePriority: RoutePriority.high,
      ),
      AircraftRoute(
        name: 'Route3',
        startPoint: items[2],
        endPoint: items[1],
        routeProfit: 200,
        routePriority: RoutePriority.mid,
      ),
    ];

    aircrafts = [
      Aircraft(
        name: 'Aircraft1',
        aircraftRoutes: [
          routes[1],
          routes[2],
        ],
        aircraftTechnicalState: AircraftTechnicalState.excellent,
        fuelAmount: 21,
        transportSpaceAmount: 50,
        aircraftCost: 12345,
        transportationResourceCost: 32,
      ),
      Aircraft(
        name: 'Aircraft2',
        aircraftRoutes: [
          routes[0],
          routes[3],
        ],
        aircraftTechnicalState: AircraftTechnicalState.good,
        fuelAmount: 16,
        transportSpaceAmount: 45,
        aircraftCost: 12344,
        transportationResourceCost: 90,
      ),
    ];
    super.initState();
  }

  List<Positioned> trajectories = [];

  Future<void>? moveThePlaneFromAtoB() {
    Timer.periodic(const Duration(milliseconds: 250), (timer) {
      setState(() {
        aircrafts.first.currentPosition += 0.05;
        aircrafts.last.currentPosition += 0.05;
        trajectories
          ..add(
            Positioned(
              left: getHorizontalPositionOfPlane(
                  aircrafts
                      .first.aircraftRoutes.first.startPoint.airportPosition.x,
                  aircrafts
                      .first.aircraftRoutes.first.endPoint.airportPosition.x,
                  aircrafts.first.currentPosition),
              top: getVerticalPositionOfPlane(
                  aircrafts
                      .first.aircraftRoutes.first.startPoint.airportPosition.y,
                  aircrafts
                      .first.aircraftRoutes.first.endPoint.airportPosition.y,
                  aircrafts.first.currentPosition),
              child: Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.redAccent),
                  color: Colors.redAccent,
                ),
              ),
            ),
          )
          ..add(Positioned(
            left: getHorizontalPositionOfPlane(
                aircrafts
                    .last.aircraftRoutes.first.startPoint.airportPosition.x,
                aircrafts
                    .last.aircraftRoutes.first.endPoint.airportPosition.x,
                aircrafts.first.currentPosition),
            top: getVerticalPositionOfPlane(
                aircrafts
                    .last.aircraftRoutes.first.startPoint.airportPosition.y,
                aircrafts
                    .last.aircraftRoutes.first.endPoint.airportPosition.y,
                aircrafts.last.currentPosition),
            child: Container(
              height: 4,
              width: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent),
                color: Colors.blueAccent,
              ),
            ),
          ),);
      });
      if (aircrafts.first.currentPosition >= 1) {
        timer.cancel();
      }
    });
    return null;
  }

  Future<void>? restorePlanes() {
    setState(() {
      aircrafts.first.currentPosition = 0;
      aircrafts.last.currentPosition = 0;
      trajectories = [];
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
              onPressed: () => moveThePlaneFromAtoB(),
              icon: const Icon(Icons.play_arrow)),
          IconButton(
              onPressed: () => restorePlanes(),
              icon: const Icon(Icons.restore_rounded)),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          child: Stack(
            children: [
              for (var airportPoint in items)
                Positioned(
                  left: getHorizontalPositionOfAirport(
                      airportPoint.airportPosition.x),
                  top: getVerticalPositionOfAirport(
                      airportPoint.airportPosition.y),
                  child: AirportWidget(airport: airportPoint),
                ),
              for (Aircraft aircarft in aircrafts)
                Positioned(
                  left: getHorizontalPositionOfPlane(
                      aircarft
                          .aircraftRoutes.first.startPoint.airportPosition.x,
                      aircarft.aircraftRoutes.first.endPoint.airportPosition.x,
                      aircarft.currentPosition),
                  top: getVerticalPositionOfPlane(
                      aircarft
                          .aircraftRoutes.first.startPoint.airportPosition.y,
                      aircarft.aircraftRoutes.first.endPoint.airportPosition.y,
                      aircarft.currentPosition),
                  child: AircraftWidget(aircraft: aircarft),
                ),
              for (Positioned trajectory in trajectories) trajectory,
            ],
          ),
        ),
      ),
    );
  }

  double getHorizontalPositionOfAirport(int airportPositionX) =>
      airportPositionX.toDouble() * 50;

  double getVerticalPositionOfAirport(int airportPositionY) =>
      airportPositionY.toDouble() * 50;

  double getHorizontalPositionOfPlane(int startAirportPositionX,
      int endAirportPositionX, double currentPosition) {
    int distanceBetween = (startAirportPositionX - endAirportPositionX).abs();

    if (startAirportPositionX == endAirportPositionX) {
      return startAirportPositionX * 50;
    } else if (startAirportPositionX > endAirportPositionX) {
      return (startAirportPositionX - currentPosition * distanceBetween) * 50;
    } else {
      return (startAirportPositionX + currentPosition * distanceBetween) * 50;
    }
  }

  double getVerticalPositionOfPlane(int startAirportPositionY,
      int endAirportPositionY, double currentPosition) {
    int distanceBetween = (startAirportPositionY - endAirportPositionY).abs();
    if (startAirportPositionY == endAirportPositionY) {
      return startAirportPositionY * 50;
    } else if (startAirportPositionY > endAirportPositionY) {
      return (startAirportPositionY - currentPosition * distanceBetween) * 50;
    } else {
      return (startAirportPositionY + currentPosition * distanceBetween) * 50;
    }
  }
}

class AirportWidget extends StatefulWidget {
  const AirportWidget({Key? key, required this.airport}) : super(key: key);

  final Airport airport;

  @override
  State<AirportWidget> createState() => _AirportWidgetState();
}

class _AirportWidgetState extends State<AirportWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
      ),
      child: Center(child: Text(widget.airport.name)),
    );
  }
}

class AircraftWidget extends StatelessWidget {
  const AircraftWidget({Key? key, required this.aircraft}) : super(key: key);
  final Aircraft aircraft;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(aircraft.name),
           IconButton(
            onPressed: null,
            icon: Icon(Icons.airplanemode_active),//FaIcon(FontAwesomeIcons.plane),
          )
        ],
      ),
    );
  }
}
