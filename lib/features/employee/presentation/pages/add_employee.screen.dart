import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../widgets/add_employee_body.widget.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Employee Details',
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
          ),
        ),
        centerTitle: false,
      ),
      body: const AddEmployeeBody(),
    );
  }
}
