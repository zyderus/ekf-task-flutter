import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/employee.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddEmployeeForm(),
      ),
    );
  }
}


class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({Key? key}) : super(key: key);

  @override
  _AddEmployeeFormState createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _positionController = TextEditingController();
  final _employeeFormKey = GlobalKey<FormState>();

  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Add info to people box
  _addInfo() async {
    Employee newEmployee = Employee(
      lastName: _lastNameController.text,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      dateOfBirth: _dateOfBirthController.text,
      position: _positionController.text,
    );

    box.add(newEmployee);
    print('Info added to box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('testBox');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _employeeFormKey,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last Name'),
          TextFormField(
            controller: _lastNameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('First Name'),
          TextFormField(
            controller: _firstNameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Middle Name'),
          TextFormField(
            controller: _middleNameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Date of Birth'),
          TextFormField(
            controller: _dateOfBirthController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Position'),
          TextFormField(
            controller: _positionController,
            validator: _fieldValidator,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_employeeFormKey.currentState!.validate()) {
                    _addInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
