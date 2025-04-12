import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/add_employee.model.dart';
import '../../../domain/usecases/add_employee_data.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final AddEmployeeData _addEmployeeData;
  AddEmployeeCubit({required AddEmployeeData addEmployeeData})
      : _addEmployeeData = addEmployeeData,
        super(AddEmployeeState.initial());

  Future<void> addNewEmployee({
    required String name,
    required String role,
    required DateTime startDate,
    required DateTime? endDate,
  }) async {
    emit(AddEmployeeState.loading());
    final failureOrResult = await _addEmployeeData(AddEmployeeModel(
      name: name,
      role: role,
      startDate: startDate,
      endDate: endDate,
    ));
    emit(_eitherAddedOrErrorState(failureOrResult));
  }

  AddEmployeeState _eitherAddedOrErrorState(
      Either<Failure, int> failureOrData) {
    return failureOrData.fold<AddEmployeeState>(
      (failure) => AddEmployeeState.error(failure.message),
      (data) {
        return AddEmployeeState.success();
      },
    );
  }
}
