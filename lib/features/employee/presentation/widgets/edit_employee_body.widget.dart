import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/utils/size_config.dart';
import '../../../shared/custom_list_tile.dart';
import '../../../shared/custom_selectable_text_field.dart';
import '../../../shared/custom_text_field.dart';
import '../cubit/edit_employee/edit_employee_cubit.dart';

class EditEmployeeBody extends StatefulWidget {
  const EditEmployeeBody({super.key, required this.id});
  final int id;

  @override
  State<EditEmployeeBody> createState() => _EditEmployeeBodyState();
}

class _EditEmployeeBodyState extends State<EditEmployeeBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  DateTime? fromDate = DateTime.now();
  DateTime? toDate;
  final FocusNode _roleFocusNode = FocusNode();
  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _toFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<EditEmployeeCubit>().getEmployee(id: widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditEmployeeCubit, EditEmployeeState>(
      listener: (context, state) {
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(milliseconds: 1000),
            ),
          );
        } else if (state is Success) {
          Navigator.pop(context);
        } else if (state is Deleted) {
          bool isTapped = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text('Employee data has been deleted'),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(milliseconds: 2000),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  isTapped = true;
                  context.read<EditEmployeeCubit>().restoreEmployee();
                },
              ),
            ),
          );
          Future.delayed(const Duration(milliseconds: 2100), () {
            if (!isTapped) {
              Navigator.pop(context);
            }
          });
        } else if (state is RestoreError) {
          bool isTapped = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(milliseconds: 2000),
              action: SnackBarAction(
                label: 'Try again',
                onPressed: () {
                  isTapped = true;
                  context.read<EditEmployeeCubit>().restoreEmployee();
                },
              ),
            ),
          );
          Future.delayed(const Duration(milliseconds: 2100), () {
            if (!isTapped) {
              Navigator.pop(context);
            }
          });
        } else if (state is Restored) {
          Navigator.pop(context);
        } else if (state is Loaded) {
          nameController.text = state.employee.name;
          roleController.text = state.employee.role;
          fromDate = state.employee.startDate;
          fromDateController.text =
              DateHelper.getDate(state.employee.startDate);
          toDate = state.employee.endDate;
          toDateController.text = DateHelper.getDate(state.employee.endDate);
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SafeArea(
            minimum: EdgeInsets.all(SizeConfig.defaultSize * 1.6),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: 'Employee name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid employee name.';
                            }
                            return null;
                          },
                          prefix: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                            child: SvgPicture.asset('assets/icons/person.svg'),
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2),
                        CustomSelectableTextField(
                          onTap: selectRole,
                          controller: roleController,
                          focusNode: _roleFocusNode,
                          hintText: 'Select Role',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a valid employee role.';
                            }
                            return null;
                          },
                          prefix: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                            child: SvgPicture.asset('assets/icons/role.svg'),
                          ),
                          suffix: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.defaultSize * 1.5),
                            child: Transform.rotate(
                              angle: pi / 2,
                              child: SvgPicture.asset(
                                'assets/icons/arrow.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.defaultSize * 2),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSelectableTextField(
                                onTap: () async {
                                  final selectedDate =
                                      await DateHelper.selectDate(context,
                                          initialDate: DateTime.now(),
                                          lastDate: toDate);
                                  fromDate = selectedDate;
                                  fromDateController.text =
                                      DateHelper.getDate(selectedDate);
                                },
                                controller: fromDateController,
                                focusNode: _fromFocusNode,
                                hintText: 'No date',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a valid date.';
                                  }
                                  return null;
                                },
                                prefix: Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize * 1.5),
                                  child: SvgPicture.asset(
                                      'assets/icons/calender.svg'),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.all(SizeConfig.defaultSize * 1.6),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: CustomSelectableTextField(
                                onTap: () async {
                                  final selectedDate =
                                      await DateHelper.selectDate(
                                    context,
                                    firstDate: fromDate,
                                  );
                                  toDate = selectedDate;
                                  toDateController.text =
                                      DateHelper.getDate(selectedDate);
                                },
                                controller: toDateController,
                                focusNode: _toFocusNode,
                                hintText: 'No date',
                                prefix: Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize * 1.5),
                                  child: SvgPicture.asset(
                                      'assets/icons/calender.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primary.withAlpha(30),
                      ),
                      onPressed: Navigator.of(context).pop,
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<EditEmployeeCubit>().updateEmployee(
                                id: widget.id,
                                name: nameController.text,
                                role: roleController.text,
                                startDate: fromDate!,
                                endDate: toDate,
                              );
                        }
                      },
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> selectRole() async {
    final selectedRole = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.defaultSize * 2),
          topRight: Radius.circular(SizeConfig.defaultSize * 2),
        ),
      ),
      builder: (_) => Container(
        decoration: ShapeDecoration(
          color: AppTheme.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.defaultSize * 2),
              topRight: Radius.circular(SizeConfig.defaultSize * 2),
            ),
          ),
        ),
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'Product Designer');
              },
              title: 'Product Designer',
            ),
            const Divider(),
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'Flutter Developer');
              },
              title: 'Flutter Developer',
            ),
            const Divider(),
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'QA Tester');
              },
              title: 'QA Tester',
            ),
            const Divider(),
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'Product Owner');
              },
              title: 'Product Owner',
            ),
            const Divider(),
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'Full-stack Developer');
              },
              title: 'Full-stack Developer',
            ),
            const Divider(),
            CustomListTile(
              onTap: () {
                Navigator.pop(context, 'Senior Software developer');
              },
              title: 'Senior Software developer',
            ),
          ],
        ),
      ),
    );
    roleController.text = selectedRole ?? '';
  }
}
