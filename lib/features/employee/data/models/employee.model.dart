import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  final int id;
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [id, name, role, startDate, endDate];
}
