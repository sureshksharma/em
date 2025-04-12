import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'core/navigation/router.dart';
import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      title: 'Employee Management',
      theme: AppTheme.theme(),
      initialRoute: Routes.HOME,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
