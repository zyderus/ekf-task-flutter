import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/employee.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Employee person;

  const UpdateScreen({
    required this.index,
    required this.person,
  });

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateEmployeeForm(
          index: widget.index,
          person: widget.person,
        ),
      ),
    );
  }
}

class UpdateEmployeeForm extends StatefulWidget {
  final int index;
  final Employee person;

  const UpdateEmployeeForm({
    required this.index,
    required this.person,
  });

  @override
  _UpdateEmployeeFormState createState() => _UpdateEmployeeFormState();
}

class _UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  final _employeeFormKey = GlobalKey<FormState>();

  late final _lastNameController;
  late final _firstNameController;
  late final _middleNameController;
  late final _dateOfBirthController;
  late final _positionController;
  
  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Update info of people box
  _updateInfo() {
    Employee newEmployee = Employee(
      lastName: _lastNameController.text,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      dateOfBirth: _dateOfBirthController.text,
      position: _positionController.text,
    );

    box.putAt(widget.index, newEmployee);

    print('Info updated in box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('testBox');
    _lastNameController = TextEditingController(text: widget.person.lastName);
    _firstNameController = TextEditingController(text: widget.person.firstName);
    _middleNameController = TextEditingController(text: widget.person.middleName);
    _dateOfBirthController = TextEditingController(text: widget.person.dateOfBirth);
    _positionController = TextEditingController(text: widget.person.position);
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
                    _updateInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}