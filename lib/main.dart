import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_challenge/app_routes.dart';
import 'package:nu_challenge/core/theme/app_theme.dart';
import 'package:nu_challenge/data/network/dio_client.dart';
import 'package:nu_challenge/data/repositories/url_shortener_repository.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MyApp());
}

/// The root widget of the application.
///
/// This widget is responsible for setting up the entire app, including:
/// - Dependency injection for repositories using [MultiRepositoryProvider].
/// - Theming and navigation using [MaterialApp].
/// - Initial route and route generation logic.
///
/// {@category App}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiRepositoryProvider is used to provide instances of repositories
    // to the entire widget tree. This allows any child widget to access
    // the repositories via `context.read<T>()`.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UrlShortenerRepository>(create: (context) => UrlShortenerRepositoryImpl(DioClient())),
        // More repositories can be added here in the future.
      ],
      child: MaterialApp(
        title: 'NU Challenge',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
