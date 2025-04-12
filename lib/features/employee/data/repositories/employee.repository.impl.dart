import 'package:dartz/dartz.dart';

import 'package:em/core/error/failures.dart';

import 'package:em/features/employee/data/models/employee.model.dart';

import '../../domain/repositories/employee.repository.dart';
import '../datasources/employee.local.datasource.dart';
import '../models/add_employee.model.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final EmployeeLocalDatasource localDataSource;

  EmployeeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, int>> deleteEmployee(int id) async {
    try {
      final result = await localDataSource.deleteEmployee(id);
      return Right(result);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EmployeeModel>> getEmployeeData(int id) async {
    try {
      final result = await localDataSource.getEmployeeData(id);
      return Right(result);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> insertEmployeeData(
      AddEmployeeModel employee) async {
    try {
      final result = await localDataSource.insertEmployeeData(employee);
      return Right(result);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateEmployeeData(
      EmployeeModel employee) async {
    try {
      final result = await localDataSource.updateEmployeeData(employee);
      return Right(result);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Stream<List<EmployeeModel>>> watchEmployees() {
    try {
      final result = localDataSource.watchEmployees();
      return Right(result);
    } on Exception {
      return const Left(CacheFailure());
    }
  }
}
