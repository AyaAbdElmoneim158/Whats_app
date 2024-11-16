import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/routes.dart';
import 'core/routing/router.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/utils/constants/app_strings.dart';
import 'features/auth/presentation/view/pages/welcome_page.dart';
import 'features/auth/presentation/view_model/auth_controller.dart';
import 'features/home_page.dart';

class WhatsApp extends ConsumerWidget {
  const WhatsApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

      /*  home: ref.watch(userInfoAuthProvider).when(
            data: (user) {
              FlutterNativeSplash.remove();
              if (user == null) return const WelcomePage();
              return const HomePage();
            },
            error: (error, trace) {
              return const Scaffold(
                body: Center(
                  child: Text('Something wrong happened'),
                ),
              );
            },
            loading: () => const SizedBox(),
          ),*/
      home: WelcomePage(),
    );
  }
}
