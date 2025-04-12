import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_employee.model.dart';
import '../../data/models/employee.model.dart';

abstract class EmployeeRepository {
  Either<Failure, Stream<List<EmployeeModel>>> watchEmployees();

  Future<Either<Failure, EmployeeModel>> getEmployeeData(int id);

  Future<Either<Failure, int>> insertEmployeeData(AddEmployeeModel employee);

  Future<Either<Failure, bool>> updateEmployeeData(EmployeeModel employee);

  Future<Either<Failure, int>> deleteEmployee(int id);
}
