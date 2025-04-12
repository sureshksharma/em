import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/employee.model.dart';
import '../repositories/employee.repository.dart';

class GetSingleEmployeeData implements UseCase<EmployeeModel, int> {
  final EmployeeRepository repository;

  GetSingleEmployeeData({required this.repository});

  @override
  Future<Either<Failure, EmployeeModel>> call(int params) async {
    return repository.getEmployeeData(params);
  }
}
