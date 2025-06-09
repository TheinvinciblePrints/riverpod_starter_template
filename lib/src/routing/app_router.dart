import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';
part 'app_router.g.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.
@riverpod
GoRouter goRouter(Ref ref) => GoRouter(
  initialLocation: Routes.home,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  redirect: _redirect,
  // refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        // return LoginScreen(
        //   viewModel: LoginViewModel(authRepository: context.read()),
        // );
        return Container();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        // final viewModel = HomeViewModel(
        //   bookingRepository: context.read(),
        //   userRepository: context.read(),
        // );
        // return HomeScreen(viewModel: viewModel);
        return Container();
      },
      routes: [
        GoRoute(
          path: Routes.searchRelative,
          builder: (context, state) {
            // final viewModel = SearchFormViewModel(
            //   continentRepository: context.read(),
            //   itineraryConfigRepository: context.read(),
            // );
            // return SearchFormScreen(viewModel: viewModel);
            return Container();
          },
        ),
        GoRoute(
          path: Routes.resultsRelative,
          builder: (context, state) {
            // final viewModel = ResultsViewModel(
            //   destinationRepository: context.read(),
            //   itineraryConfigRepository: context.read(),
            // );
            // return ResultsScreen(viewModel: viewModel);
            return Container();
          },
        ),
        GoRoute(
          path: Routes.activitiesRelative,
          builder: (context, state) {
            // final viewModel = ActivitiesViewModel(
            //   activityRepository: context.read(),
            //   itineraryConfigRepository: context.read(),
            // );
            // return ActivitiesScreen(viewModel: viewModel);
            return Container();
          },
        ),
        GoRoute(
          path: Routes.bookingRelative,
          builder: (context, state) {
            // final viewModel = BookingViewModel(
            //   itineraryConfigRepository: context.read(),
            //   createBookingUseCase: context.read(),
            //   shareBookingUseCase: context.read(),
            //   bookingRepository: context.read(),
            // );

            // // When opening the booking screen directly
            // // create a new booking from the stored ItineraryConfig.
            // viewModel.createBooking.execute();

            // return BookingScreen(viewModel: viewModel);
            return Container();
          },
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                // final id = int.parse(state.pathParameters['id']!);
                // final viewModel = BookingViewModel(
                //   itineraryConfigRepository: context.read(),
                //   createBookingUseCase: context.read(),
                //   shareBookingUseCase: context.read(),
                //   bookingRepository: context.read(),
                // );

                // // When opening the booking screen with an existing id
                // // load and display that booking.
                // viewModel.loadBooking.execute(id);

                // return BookingScreen(viewModel: viewModel);
                return Container();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // // if the user is not logged in, they need to login
  // final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  // final loggingIn = state.matchedLocation == Routes.login;
  // if (!loggedIn) {
  //   return Routes.login;
  // }

  // // if the user is logged in but still on the login page, send them to
  // // the home page
  // if (loggingIn) {
  //   return Routes.home;
  // }

  // no need to redirect at all
  return null;
}
