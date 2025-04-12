import 'package:em/core/utils/date.extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/size_config.dart';
import '../../data/models/employee.model.dart';
import '../cubit/home_cubit.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.EDIT_EMPLOYEE,
            arguments: {'id': employee.id});
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            context.read<HomeCubit>().deleteEmployee(employee: employee);
          }
        },
        background: Container(
          padding: EdgeInsets.only(right: SizeConfig.defaultSize * 2),
          alignment: Alignment.centerRight,
          color: AppTheme.colorRed,
          child: SvgPicture.asset(
            'assets/icons/delete.svg',
            height: SizeConfig.defaultSize * 2,
            width: SizeConfig.defaultSize * 2,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.6),
          decoration: BoxDecoration(
            color: AppTheme.colorWhite,
            border: Border(
              bottom: BorderSide(
                color: AppTheme.colorLightGray,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                employee.name,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 0.8),
              Text(
                employee.role,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.4,
                  color: AppTheme.colorDarkGray,
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 0.8),
              Text(
                employee.endDate != null
                    ? '${employee.startDate.toDMMMYWithComma()} - ${employee.endDate!.toDMMMYWithComma()}'
                    : 'From ${employee.startDate.toDMMMYWithComma()}',
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.2,
                  color: AppTheme.colorDarkGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
