import 'package:aircrafts_router/src/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'algorithm_util/models/aircraft.dart';
import 'algorithm_util/models/airport.dart';
import 'algorithm_util/models/aircraft_route.dart';
import 'bloc/core_data_bloc.dart';
import 'features/sample_feature/sample_item_details_view.dart';
import 'features/sample_feature/sample_item_list_view.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  final List<Airport> airports = [
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
        startPoint: airports[0],
        endPoint: airports[2],
        routeProfit: 100,
        routePriority: RoutePriority.low,
      ),
      AircraftRoute(
        name: 'Route2',
        startPoint: airports[1],
        //1 = b
        endPoint: airports[4],
        //4 = e
        routeProfit: 130,
        routePriority: RoutePriority.mid,
      ),
      AircraftRoute(
        name: 'Route3',
        startPoint: airports[4],
        endPoint: airports[1],
        routeProfit: 230,
        routePriority: RoutePriority.high,
      ),
      AircraftRoute(
        name: 'Route3',
        startPoint: airports[2],
        endPoint: airports[1],
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
  }

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return BlocProvider<CoreDataBloc>(
                        builder: (_) =>
                            CoreDataBloc(airports, routes, aircrafts),
                        child: SampleItemListView());
                }
              },
            );
          },
        );
      },
    );
  }
}
