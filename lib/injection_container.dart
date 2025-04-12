import 'package:get_it/get_it.dart';

import 'core/local/database.dart';
import 'core/local/platform/platform.dart';
import 'features/employee/data/datasources/employee.local.datasource.dart';
import 'features/employee/data/repositories/employee.repository.impl.dart';
import 'features/employee/domain/repositories/employee.repository.dart';
import 'features/employee/domain/usecases/add_employee_data.dart';
import 'features/employee/domain/usecases/delete_employee_data.dart';
import 'features/employee/domain/usecases/get_single_employee_data.dart';
import 'features/employee/domain/usecases/update_employee_data.dart';
import 'features/employee/domain/usecases/watch_employees_data.dart';
import 'features/employee/presentation/cubit/add_employee/add_employee_cubit.dart';
import 'features/employee/presentation/cubit/edit_employee/edit_employee_cubit.dart';
import 'features/employee/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(
    () => HomeCubit(
      watchEmployeesData: sl(),
      deleteEmployeeData: sl(),
      addEmployeeData: sl(),
    ),
  );
  sl.registerFactory(
    () => AddEmployeeCubit(
      addEmployeeData: sl(),
    ),
  );
  sl.registerFactory(
    () => EditEmployeeCubit(
      getSingleEmployeeData: sl(),
      updateEmployeeData: sl(),
      deleteEmployeeData: sl(),
      addEmployeeData: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => WatchEmployeesData(repository: sl()));
  sl.registerLazySingleton(() => AddEmployeeData(repository: sl()));
  sl.registerLazySingleton(() => UpdateEmployeeData(repository: sl()));
  sl.registerLazySingleton(() => GetSingleEmployeeData(repository: sl()));
  sl.registerLazySingleton(() => DeleteEmployeeData(repository: sl()));

  // Repositories
  sl.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(localDataSource: sl()));

  // Datasourses
  sl.registerLazySingleton<EmployeeLocalDatasource>(
      () => EmployeeLocalDatasourceImpl(database: sl()));

  // External
  final qe = DBCreator.createDatabaseConnection('employee-management');
  sl.registerSingleton<AppDatabase>(AppDatabase(qe));
}
