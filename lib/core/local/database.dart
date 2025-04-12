import 'package:drift/drift.dart';

import '../../features/employee/data/models/add_employee.model.dart';
import '../../features/employee/data/models/employee.model.dart';
import '../../features/employee/domain/entities/employee_entity.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Employee])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.forTesting(DatabaseConnection super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    }, onCreate: (m) async {
      await m.createAll();
    });
  }

  Future<int> addEmployee(AddEmployeeModel employeeData) {
    return into(employee).insert(EmployeeCompanion.insert(
      id: Value.absentIfNull(employeeData.id),
      name: employeeData.name,
      role: employeeData.role,
      startDate: employeeData.startDate,
      endDate: Value.absentIfNull(employeeData.endDate),
    ));
  }

  Future<List<EmployeeModel>> get allEmployeeData => select(employee)
      .map((data) => EmployeeModel(
          id: data.id,
          name: data.name,
          role: data.role,
          startDate: data.startDate,
          endDate: data.endDate))
      .get();

  Stream<List<EmployeeModel>> watchEmployees() {
    return select(employee)
        .map((data) => EmployeeModel(
            id: data.id,
            name: data.name,
            role: data.role,
            startDate: data.startDate,
            endDate: data.endDate))
        .watch();
  }

  Future<EmployeeModel> employeeData(int id) async {
    final emp =
        await (select(employee)..where((t) => t.id.equals(id))).getSingle();
    return EmployeeModel(
        id: emp.id,
        name: emp.name,
        role: emp.role,
        startDate: emp.startDate,
        endDate: emp.endDate);
  }

  Future<bool> updateEmployee(EmployeeModel employeeData) {
    return update(employee).replace(EmployeeData(
        id: employeeData.id,
        name: employeeData.name,
        role: employeeData.role,
        startDate: employeeData.startDate,
        endDate: employeeData.endDate));
  }

  Future<int> deleteEmployeeRow(int id) {
    return (delete(employee)..where((t) => t.id.equals(id))).go();
  }
}
