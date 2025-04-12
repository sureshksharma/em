part of 'edit_employee_cubit.dart';

sealed class EditEmployeeState extends Equatable {
  const EditEmployeeState();
  const factory EditEmployeeState.initial() = Initial;
  const factory EditEmployeeState.loading() = Loading;
  const factory EditEmployeeState.success() = Success;
  const factory EditEmployeeState.deleted() = Deleted;
  const factory EditEmployeeState.loaded(EmployeeModel employee) = Loaded;
  const factory EditEmployeeState.restored() = Restored;
  const factory EditEmployeeState.errorRestore(String message) = RestoreError;
  const factory EditEmployeeState.error(String message) = Error;

  @override
  List<Object?> get props => [];
}

class Initial extends EditEmployeeState {
  const Initial();
}

class Loading extends EditEmployeeState {
  const Loading();
}

class Success extends EditEmployeeState {
  const Success();
}

class Deleted extends EditEmployeeState {
  const Deleted();
}

class Restored extends EditEmployeeState {
  const Restored();
}

class RestoreError extends EditEmployeeState {
  final String message;
  const RestoreError(this.message);

  @override
  List<Object?> get props => [message];
}

class Loaded extends EditEmployeeState {
  final EmployeeModel employee;
  const Loaded(this.employee);

  @override
  List<Object?> get props => [employee];
}

class Error extends EditEmployeeState {
  final String message;
  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
