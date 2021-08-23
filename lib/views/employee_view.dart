import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/employee.dart';
import './employee_update.dart';
import './child_add.dart';
// import './children_list.dart';
// import './children_list.dart';

class EmployeeView extends StatefulWidget {
  final int index;
  final Employee person;

  const EmployeeView({
    required this.index,
    required this.person,
  });

  @override
  _EmployeeViewState createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Employee: ${widget.person.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EmployeeViewer(
          index: widget.index,
          person: widget.person,
        ),
      ),
    );
  }
}

class EmployeeViewer extends StatefulWidget {
  final int index;
  final Employee person;

  const EmployeeViewer({
    required this.index,
    required this.person,
  });

  @override
  _EmployeeViewerState createState() => _EmployeeViewerState();
}

class _EmployeeViewerState extends State<EmployeeViewer> {

  late final Box box;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('testBox');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                foregroundImage: AssetImage('images/avatar.jpg'),
              ),
              Text(
                '${widget.person.firstName} ${widget.person.middleName} ${widget.person.lastName}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.person.position,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                        index: widget.index,
                        person: widget.person,
                      ),
                    ),
                  ),
                child: Text('Update'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHILDREN',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddChildScreen(),
                  ),
                ),
                child: Icon(Icons.add),
              ),
            ],
          ),
        // ChildrenScreen(),
        ],
      );
  }
}