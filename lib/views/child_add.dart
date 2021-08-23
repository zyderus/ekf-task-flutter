import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/child.dart';

class AddChildScreen extends StatefulWidget {
  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add New Child'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddChildForm(),
      ),
    );
  }
}


class AddChildForm extends StatefulWidget {
  const AddChildForm({Key? key}) : super(key: key);

  @override
  _AddChildFormState createState() => _AddChildFormState();
}

class _AddChildFormState extends State<AddChildForm> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _childFormKey = GlobalKey<FormState>();

  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Add info to people box
  _addInfo() async {
    Child newChild = Child(
      lastName: _lastNameController.text,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      dateOfBirth: _dateOfBirthController.text,
    );

    box.add(newChild);
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
      key: _childFormKey,
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_childFormKey.currentState!.validate()) {
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
