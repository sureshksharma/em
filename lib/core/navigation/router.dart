import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/employee/presentation/cubit/add_employee/add_employee_cubit.dart';
import '../../features/employee/presentation/cubit/edit_employee/edit_employee_cubit.dart';
import '../../features/employee/presentation/cubit/home_cubit.dart';
import '../../features/employee/presentation/pages/add_employee.screen.dart';
import '../../features/employee/presentation/pages/edit_employee.screen.dart';
import '../../features/employee/presentation/pages/home.screen.dart';
import '../../features/employee/presentation/pages/page_not_found.screen.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => sl<HomeCubit>(),
                  child: const HomeScreen(),
                ));

      case Routes.ADD_EMPLOYEE:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => sl<AddEmployeeCubit>(),
                  child: const AddEmployeeScreen(),
                ));

      case Routes.EDIT_EMPLOYEE:
        {
          final args = settings.arguments as Map<String, int>;

          return MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => sl<EditEmployeeCubit>(),
                child: EditEmployeeScreen(
                  id: args['id'] ?? 0,
                ),
              );
            },
          );
        }
      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFoundScreen());
    }
  }
}
