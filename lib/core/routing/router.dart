import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case Routes.initRoute:
        return pageTransition(
          settings,
          const Scaffold(
            body: Center(child: Text("whatsapp_messenger")),
          ),
        );
      default:
        return _buildNotFoundRoute();
    }
  }

  static PageTransition<dynamic> pageTransition(
    RouteSettings settings,
    Widget screen, {
    PageTransitionType type = PageTransitionType.fade,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return PageTransition(
      type: type,
      child: screen,
      settings: settings,
      duration: duration,
    );
  }

  static MaterialPageRoute<dynamic> _buildNotFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Oops! We couldn’t navigate to the page.'),
      ),
    );
  }
}
