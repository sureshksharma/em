import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/employee.model.dart';
import '../repositories/employee.repository.dart';

class WatchEmployeesData
    implements UseCase<Stream<List<EmployeeModel>>, NoParams> {
  final EmployeeRepository repository;

  WatchEmployeesData({required this.repository});

  @override
  Future<Either<Failure, Stream<List<EmployeeModel>>>> call(
      NoParams params) async {
    return repository.watchEmployees();
  }
}

class NoParams {}
