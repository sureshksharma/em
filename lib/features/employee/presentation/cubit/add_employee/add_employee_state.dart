part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();
  const factory AddEmployeeState.initial() = Initial;
  const factory AddEmployeeState.loading() = Loading;
  const factory AddEmployeeState.success() = Success;
  const factory AddEmployeeState.error(String message) = Error;

  @override
  List<Object?> get props => [];
}

class Initial extends AddEmployeeState {
  const Initial();
}

class Loading extends AddEmployeeState {
  const Loading();
}

class Success extends AddEmployeeState {
  const Success();
}

class Error extends AddEmployeeState {
  final String message;
  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
