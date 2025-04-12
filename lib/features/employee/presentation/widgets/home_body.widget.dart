import 'package:em/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../../core/theme/app_theme.dart';
import '../cubit/home_cubit.dart';
import 'employee_card.widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<HomeCubit>().watchEmployees();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is Deleted) {
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
                  context.read<HomeCubit>().restoreEmployee();
                },
              ),
            ),
          );
        } else if (state is RestoreError) {
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
                  context.read<HomeCubit>().restoreEmployee();
                },
              ),
            ),
          );
        } else if (state is Restored) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text('Employee restored'),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(milliseconds: 1000),
            ),
          );
        } else if (state is Error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.fixed,
              duration: const Duration(milliseconds: 1000),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: StreamBuilder(
            stream: context.read<HomeCubit>().employeesData,
            builder: (context, snapshot) {
              final employees = snapshot.data ?? [];
              if (snapshot.connectionState == ConnectionState.active &&
                  employees.isNotEmpty) {
                final currentEmployees =
                    employees.where((e) => e.endDate == null).toList();
                final previousEmployees =
                    employees.where((e) => e.endDate != null).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: DefaultStickyHeaderController(
                        child: CustomScrollView(
                          slivers: [
                            if (currentEmployees.isNotEmpty)
                              SliverStickyHeader(
                                header: Container(
                                  height: SizeConfig.defaultSize * 5.6,
                                  color: AppTheme.colorLightGray,
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize * 1.6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Current employees',
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: currentEmployees.length,
                                    (context, i) {
                                      return EmployeeCard(
                                        employee: currentEmployees[i],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            if (previousEmployees.isNotEmpty)
                              SliverStickyHeader(
                                header: Container(
                                  height: SizeConfig.defaultSize * 5.6,
                                  color: AppTheme.colorLightGray,
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize * 1.6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Previous employees',
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize * 1.6,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: previousEmployees.length,
                                    (context, i) {
                                      return EmployeeCard(
                                        employee: previousEmployees[i],
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: kBottomNavigationBarHeight +
                          SizeConfig.defaultSize * 2,
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.topLeft,
                      color: AppTheme.colorLightGray,
                      child: SafeArea(
                        minimum: EdgeInsets.all(SizeConfig.defaultSize),
                        child: Text(
                          'Swipe left to delete',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.colorDarkGray,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active &&
                  employees.isEmpty) {
                return Container(
                  color: AppTheme.colorLightGray,
                  child: Center(
                    child: Image.asset(
                      'assets/images/no_data.webp',
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
