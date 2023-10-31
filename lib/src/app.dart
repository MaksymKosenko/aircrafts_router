import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'algorithm_util/models/aircraft.dart';
import 'algorithm_util/models/airport.dart';
import 'algorithm_util/models/aircraft_route.dart';
import 'bloc/core_data_cubit/core_data_cubit.dart';
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

  final List<AircraftRoute> routes = [
    AircraftRoute(
      name: "Route 1",
      startPoint: Airport(
        name: "Airport A",
        airportPosition: AirportPosition(1, 2),
        fuelAmount: 5000.0,
        totalAircraftAmount: 10,
      ),
      endPoint: Airport(
        name: "Airport B",
        airportPosition: AirportPosition(5, 8),
        fuelAmount: 6000.0,
        totalAircraftAmount: 12,
      ),
      routeProfit: 10000,
      routePriority: RoutePriority.high,
    ),
    AircraftRoute(
      name: "Route 2",
      startPoint: Airport(
        name: "Airport C",
        airportPosition: AirportPosition(2, 3),
        fuelAmount: 5500.0,
        totalAircraftAmount: 8,
      ),
      endPoint: Airport(
        name: "Airport D",
        airportPosition: AirportPosition(6, 9),
        fuelAmount: 7000.0,
        totalAircraftAmount: 14,
      ),
      routeProfit: 12000,
      routePriority: RoutePriority.critical,
    ),
  ];
  final List<Aircraft> aircrafts = [
    Aircraft(
      name: "Boeing 747",
      aircraftRoutes: [
        AircraftRoute(
          name: "Route 1",
          startPoint: Airport(
            name: "Airport A",
            airportPosition: AirportPosition(1, 2),
            fuelAmount: 5000.0,
            totalAircraftAmount: 10,
          ),
          endPoint: Airport(
            name: "Airport B",
            airportPosition: AirportPosition(5, 8),
            fuelAmount: 6000.0,
            totalAircraftAmount: 12,
          ),
          routeProfit: 10000,
          routePriority: RoutePriority.high,
        ),
      ],
      aircraftTechnicalState: AircraftTechnicalState.good,
      fuelAmount: 5000.0,
      transportSpaceAmount: 300,
      aircraftCost: 100000000,
      transportationResourceCost: 1000,
    ),
    Aircraft(
      name: "Airbus A380",
      aircraftRoutes: [
        AircraftRoute(
          name: "Route 2",
          startPoint: Airport(
            name: "Airport C",
            airportPosition: AirportPosition(2, 3),
            fuelAmount: 5500.0,
            totalAircraftAmount: 8,
          ),
          endPoint: Airport(
            name: "Airport D",
            airportPosition: AirportPosition(6, 9),
            fuelAmount: 7000.0,
            totalAircraftAmount: 14,
          ),
          routeProfit: 12000,
          routePriority: RoutePriority.critical,
        ),
      ],
      aircraftTechnicalState: AircraftTechnicalState.excellent,
      fuelAmount: 6000.0,
      transportSpaceAmount: 350,
      aircraftCost: 120000000,
      transportationResourceCost: 1200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (_) => CoreDataCubit(
            airports: airports,
            aircraftRoutes: routes,
            aircrafts: aircrafts,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
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
                      return const SampleItemListView();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
