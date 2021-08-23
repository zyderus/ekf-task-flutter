import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 1)
class Employee {
  @HiveField(0)
  final String lastName;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String middleName;
  @HiveField(3)
  final String dateOfBirth;
  @HiveField(4)
  final String position;

  Employee({
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.dateOfBirth,
    required this.position,
  });
}
