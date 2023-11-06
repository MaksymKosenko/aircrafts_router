import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'algorithm_util/algorithm_util.dart';
import 'algorithm_util/models/aircraft.dart';
import 'algorithm_util/models/airport.dart';
import 'algorithm_util/models/aircraft_route.dart';
import 'bloc/aircraft_flight_simulation_cubit/aircraft_flight_simulation_cubit.dart';
import 'bloc/core_data_cubit/core_data_cubit.dart';
import 'features/sample_feature/sample_item_details_view.dart';
import 'features/sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.settingsController}) : super(key: key);

  final SettingsController settingsController;

  final List<Airport> airports = [
    Airport(
      name: "A",
      airportPosition: const AirportPosition(4, 10),
      fuelAmount: 40,
      totalAircraftAmount: 3,
    ),
    Airport(
      name: "B",
      airportPosition: const AirportPosition(10, 0),
      fuelAmount: 40,
      totalAircraftAmount: 3,
    ),
    Airport(
      name: "D",
      airportPosition: const AirportPosition(0, 0),
      fuelAmount: 40,
      totalAircraftAmount: 3,
    ),
    Airport(
      name: "E",
      airportPosition: const AirportPosition(0, 3),
      fuelAmount: 40,
      totalAircraftAmount: 3,
    ),
    Airport(
      name: "C",
      airportPosition: const AirportPosition(5, 5),
      fuelAmount: 40,
      totalAircraftAmount: 3,
    ),
  ];

  List<AircraftRoute> get routes => [
        AircraftRoute(
          name: "Route 1",
          startPoint: airports[0],
          endPoint: airports[1],
          routeProfit: 10000,
          routePriority: RoutePriority.high,
        ),
        AircraftRoute(
          name: "Route 2",
          startPoint: airports[2],
          endPoint: airports[3],
          routeProfit: 12000,
          routePriority: RoutePriority.critical,
        ),
        AircraftRoute(
          name: "Route 3",
          // New route
          startPoint: airports[1],
          endPoint: airports[4],
          routeProfit: 15000,
          routePriority: RoutePriority.mid,
        ),
      ];

  List<Aircraft> get aircrafts => [
        Aircraft(
          name: "Boeing 747",
          aircraftRoutes: [routes[0]],
          aircraftTechnicalState: AircraftTechnicalState.good,
          fuelAmount: 5000.0,
          transportSpaceAmount: 300,
          aircraftCost: 100000000,
          transportationResourceCost: 1000,
        ),
        Aircraft(
          name: "Airbus A380",
          aircraftRoutes: [routes[1]],
          aircraftTechnicalState: AircraftTechnicalState.excellent,
          fuelAmount: 6000.0,
          transportSpaceAmount: 400,
          aircraftCost: 120000000,
          transportationResourceCost: 1200,
        ),
        Aircraft(
          name: "Messerschmitt Bf 109 ✙",
          aircraftRoutes: [routes[2]],
          aircraftTechnicalState: AircraftTechnicalState.good,
          fuelAmount: 5500.0,
          transportSpaceAmount: 100,
          aircraftCost: 110000000,
          transportationResourceCost: 1100,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    AlgorithmUtil().generateRoutesScheme(airports, routes, aircrafts);
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CoreDataCubit(
                airports: airports,
                aircraftRoutes: AlgorithmUtil().generatedRoutes,
                aircrafts: aircrafts,
              ),
            ),
            BlocProvider(
              create: (_) => AircraftFlightSimulationCubit(aircrafts),
            ),
          ],
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
            theme: ThemeData(useMaterial3: true),
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
