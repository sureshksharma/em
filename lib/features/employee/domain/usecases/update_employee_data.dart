import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/employee.model.dart';
import '../repositories/employee.repository.dart';

class UpdateEmployeeData implements UseCase<bool, EmployeeModel> {
  final EmployeeRepository repository;

  UpdateEmployeeData({required this.repository});

  @override
  Future<Either<Failure, bool>> call(EmployeeModel params) async {
    return repository.updateEmployeeData(params);
  }
}
