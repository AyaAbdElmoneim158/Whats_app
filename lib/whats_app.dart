import 'package:flutter/material.dart';
import 'core/routing/routes.dart';
import 'core/routing/router.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/constants/app_strings.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      // Theme - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // Routing - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: Routes.initRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const NotFoundPage(),
      ),
    );
  }
}
