import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/size_config.dart';
import '../cubit/edit_employee/edit_employee_cubit.dart';
import '../widgets/edit_employee_body.widget.dart';

class EditEmployeeScreen extends StatelessWidget {
  const EditEmployeeScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Employee Details',
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.read<EditEmployeeCubit>().deleteEmployee(id: id);
            },
            icon: SvgPicture.asset(
              'assets/icons/delete.svg',
              height: SizeConfig.defaultSize * 2,
              width: SizeConfig.defaultSize * 2,
            ),
          )
        ],
      ),
      body: EditEmployeeBody(id: id),
    );
  }
}
