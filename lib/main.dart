import 'package:flutter/material.dart';
import './models/employee.dart';
// import './models/child.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './views/employee_list.dart';

main() async {
  // Initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  // Hive.registerAdapter(ChildAdapter());
  await Hive.openBox('testBox');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: InfoScreen(),
    );
  }
}
