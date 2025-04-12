import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_employee.model.dart';
import '../../data/models/employee.model.dart';
import '../../domain/usecases/add_employee_data.dart';
import '../../domain/usecases/delete_employee_data.dart';
import '../../domain/usecases/watch_employees_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AddEmployeeData _addEmployeeData;
  final WatchEmployeesData _watchEmployeesData;
  final DeleteEmployeeData _deleteEmployeeData;
  EmployeeModel? lastDeletedEmployee;
  ReplaySubject<List<EmployeeModel>> employeesData = ReplaySubject();
  HomeCubit({
    required WatchEmployeesData watchEmployeesData,
    required DeleteEmployeeData deleteEmployeeData,
    required AddEmployeeData addEmployeeData,
  })  : _watchEmployeesData = watchEmployeesData,
        _deleteEmployeeData = deleteEmployeeData,
        _addEmployeeData = addEmployeeData,
        super(HomeState.initial());

  Future<void> watchEmployees() async {
    emit(HomeState.loading());
    final failureOrResult = await _watchEmployeesData(NoParams());
    emit(_eitherLoadedOrErrorState(failureOrResult));
  }

  Future<void> deleteEmployee({required EmployeeModel employee}) async {
    emit(HomeState.loading());
    lastDeletedEmployee = employee;
    final failureOrResult = await _deleteEmployeeData(employee.id);
    emit(_eitherDeletedOrErrorState(failureOrResult));
  }

  Future<void> restoreEmployee() async {
    if (lastDeletedEmployee != null) {
      emit(HomeState.loading());
      final failureOrResult = await _addEmployeeData(AddEmployeeModel(
        id: lastDeletedEmployee!.id,
        name: lastDeletedEmployee!.name,
        role: lastDeletedEmployee!.role,
        startDate: lastDeletedEmployee!.startDate,
        endDate: lastDeletedEmployee!.endDate,
      ));
      emit(_eitherRestoredOrErrorState(failureOrResult));
    } else {
      emit(HomeState.errorRestore('Unable to restore employee.'));
    }
  }

  HomeState _eitherLoadedOrErrorState(
      Either<Failure, Stream<List<EmployeeModel>>> failureOrData) {
    return failureOrData.fold<HomeState>(
      (failure) => HomeState.error(failure.message),
      (data) {
        employeesData.addStream(data);
        return HomeState.loaded();
      },
    );
  }

  HomeState _eitherDeletedOrErrorState(Either<Failure, int> failureOrData) {
    return failureOrData.fold<HomeState>(
      (failure) {
        lastDeletedEmployee = null;
        return HomeState.error(failure.message);
      },
      (data) {
        return HomeState.deleted();
      },
    );
  }

  HomeState _eitherRestoredOrErrorState(Either<Failure, int> failureOrData) {
    return failureOrData.fold<HomeState>(
      (failure) => HomeState.errorRestore('Unable to restore employee.'),
      (data) {
        lastDeletedEmployee = null;
        return HomeState.restored();
      },
    );
  }
}
