class AddEmployeeModel {
  final int? id;
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  AddEmployeeModel({
    this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });
}
