import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/employee.repository.dart';

class DeleteEmployeeData implements UseCase<int, int> {
  final EmployeeRepository repository;

  DeleteEmployeeData({required this.repository});

  @override
  Future<Either<Failure, int>> call(int params) async {
    return repository.deleteEmployee(params);
  }
}
