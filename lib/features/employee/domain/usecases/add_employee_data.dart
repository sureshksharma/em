import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/add_employee.model.dart';
import '../repositories/employee.repository.dart';

class AddEmployeeData implements UseCase<int, AddEmployeeModel> {
  final EmployeeRepository repository;

  AddEmployeeData({required this.repository});

  @override
  Future<Either<Failure, int>> call(AddEmployeeModel params) async {
    return repository.insertEmployeeData(params);
  }
}
