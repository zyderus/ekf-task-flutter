import 'package:hive/hive.dart';

part 'child.g.dart';

@HiveType(typeId: 1)
class Child {
  @HiveField(0)
  final String lastName;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String middleName;
  @HiveField(3)
  final String dateOfBirth;

  Child({
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.dateOfBirth,
  });
}
