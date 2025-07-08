import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_challenge/data/repositories/url_shortener_repository.dart';
import 'package:nu_challenge/features/about/about_page.dart';
import 'package:nu_challenge/features/home/home_cubit.dart';
import 'package:nu_challenge/features/home/home_page.dart';

/// A class that holds the route names for the application.
///
/// Using static constants for route names helps prevent typos and makes it
/// easier to manage all routes from a single location.
class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
}

/// The main router for the application.
///
/// This class is responsible for handling named routes and generating the
/// appropriate pages based on the route settings.
///
/// {@category App}
class AppRouter {
  /// A static method that generates routes based on the provided [settings].
  ///
  /// This function is typically used in the `onGenerateRoute` property of
  /// the [MaterialApp] widget. It uses a switch statement to return the
  /// correct page for a given route name.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(context.read<UrlShortenerRepository>()),
            child: const HomePage(),
          ),
        );

      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutPage());

      // If the route name is not recognized, a default "not found"
      // page is displayed.
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Página não encontrada!'))),
        );
    }
  }
}
