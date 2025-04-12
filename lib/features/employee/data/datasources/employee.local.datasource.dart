import '../../../../core/local/database.dart';
import '../models/add_employee.model.dart';
import '../models/employee.model.dart';

abstract class EmployeeLocalDatasource {
  Stream<List<EmployeeModel>> watchEmployees();

  Future<EmployeeModel> getEmployeeData(int id);

  Future<int> insertEmployeeData(AddEmployeeModel employee);

  Future<bool> updateEmployeeData(EmployeeModel employee);

  Future<int> deleteEmployee(int id);
}

class EmployeeLocalDatasourceImpl extends EmployeeLocalDatasource {
  final AppDatabase _database;

  EmployeeLocalDatasourceImpl({required AppDatabase database})
      : _database = database;

  @override
  Stream<List<EmployeeModel>> watchEmployees() {
    return _database.watchEmployees();
  }

  @override
  Future<EmployeeModel> getEmployeeData(int id) {
    return _database.employeeData(id);
  }

  @override
  Future<int> insertEmployeeData(AddEmployeeModel employee) {
    return _database.addEmployee(employee);
  }

  @override
  Future<bool> updateEmployeeData(EmployeeModel employee) {
    return _database.updateEmployee(employee);
  }

  @override
  Future<int> deleteEmployee(int id) {
    return _database.deleteEmployeeRow(id);
  }
}
