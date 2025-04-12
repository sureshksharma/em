import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/add_employee.model.dart';
import '../../../data/models/employee.model.dart';
import '../../../domain/usecases/add_employee_data.dart';
import '../../../domain/usecases/delete_employee_data.dart';
import '../../../domain/usecases/get_single_employee_data.dart';
import '../../../domain/usecases/update_employee_data.dart';

part 'edit_employee_state.dart';

class EditEmployeeCubit extends Cubit<EditEmployeeState> {
  final AddEmployeeData _addEmployeeData;
  final GetSingleEmployeeData _getSingleEmployeeData;
  final UpdateEmployeeData _updateEmployeeData;
  final DeleteEmployeeData _deleteEmployeeData;
  EmployeeModel? lastDeletedEmployee;
  
  EditEmployeeCubit({
    required AddEmployeeData addEmployeeData,
    required GetSingleEmployeeData getSingleEmployeeData,
    required UpdateEmployeeData updateEmployeeData,
    required DeleteEmployeeData deleteEmployeeData,
  })  : _getSingleEmployeeData = getSingleEmployeeData,
        _updateEmployeeData = updateEmployeeData,
        _deleteEmployeeData = deleteEmployeeData,
        _addEmployeeData = addEmployeeData,
        super(EditEmployeeState.initial());

  Future<void> getEmployee({required int id}) async {
    emit(EditEmployeeState.loading());
    final failureOrResult = await _getSingleEmployeeData(id);
    emit(_eitherLoadedOrErrorState(failureOrResult));
  }

  Future<void> deleteEmployee({required int id}) async {
    emit(EditEmployeeState.loading());
    final failureOrResult = await _deleteEmployeeData(id);
    emit(_eitherDeletedOrErrorState(failureOrResult));
  }

  Future<void> restoreEmployee() async {
    if (lastDeletedEmployee != null) {
      emit(EditEmployeeState.loading());
      final failureOrResult = await _addEmployeeData(AddEmployeeModel(
        id: lastDeletedEmployee!.id,
        name: lastDeletedEmployee!.name,
        role: lastDeletedEmployee!.role,
        startDate: lastDeletedEmployee!.startDate,
        endDate: lastDeletedEmployee!.endDate,
      ));
      emit(_eitherRestoredOrErrorState(failureOrResult));
    } else {
      emit(EditEmployeeState.errorRestore('Unable to restore employee.'));
    }
  }

  Future<void> updateEmployee({
    required int id,
    required String name,
    required String role,
    required DateTime startDate,
    required DateTime? endDate,
  }) async {
    emit(EditEmployeeState.loading());
    final failureOrResult = await _updateEmployeeData(EmployeeModel(
      id: id,
      name: name,
      role: role,
      startDate: startDate,
      endDate: endDate,
    ));
    emit(_eitherUpdatedOrErrorState(failureOrResult));
  }

  EditEmployeeState _eitherLoadedOrErrorState(
      Either<Failure, EmployeeModel> failureOrData) {
    return failureOrData.fold<EditEmployeeState>(
      (failure) => EditEmployeeState.error(failure.message),
      (data) {
        lastDeletedEmployee = data;
        return EditEmployeeState.loaded(data);
      },
    );
  }

  EditEmployeeState _eitherUpdatedOrErrorState(
      Either<Failure, bool> failureOrData) {
    return failureOrData.fold<EditEmployeeState>(
      (failure) => EditEmployeeState.error(failure.message),
      (data) {
        return EditEmployeeState.success();
      },
    );
  }

  EditEmployeeState _eitherDeletedOrErrorState(
      Either<Failure, int> failureOrData) {
    return failureOrData.fold<EditEmployeeState>(
      (failure) => EditEmployeeState.error(failure.message),
      (data) {
        return EditEmployeeState.deleted();
      },
    );
  }

  EditEmployeeState _eitherRestoredOrErrorState(Either<Failure, int> failureOrData) {
    return failureOrData.fold<EditEmployeeState>(
      (failure) => EditEmployeeState.errorRestore('Unable to restore employee.'),
      (data) {
        lastDeletedEmployee = null;
        return EditEmployeeState.restored();
      },
    );
  }
}
