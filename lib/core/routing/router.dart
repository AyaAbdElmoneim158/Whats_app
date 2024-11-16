import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/auth/presentation/view/pages/login_page.dart';
import '../../features/auth/presentation/view/pages/user_info_page.dart';
import '../../features/auth/presentation/view/pages/verification_page.dart';
import '../../features/auth/presentation/view/pages/welcome_page.dart';
import '../../features/home_page.dart';
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
      case Routes.welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case Routes.verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => VerificationPage(
            smsCodeId: args['smsCodeId'],
            phoneNumber: args['phoneNumber'],
          ),
        );
      case Routes.userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => UserInfoPage(
            profileImageUrl: profileImageUrl,
          ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
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
