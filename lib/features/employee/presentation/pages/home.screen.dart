import 'package:flutter/material.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/size_config.dart';
import '../widgets/home_body.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: TextStyle(
            fontSize: SizeConfig.defaultSize * 1.8,
          ),
        ),
        centerTitle: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 0.8),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.ADD_EMPLOYEE);
          },
          child: Icon(
            Icons.add,
            color: AppTheme.colorWhite,
          ),
        ),
      ),
      body: const HomeBody(),
    );
  }
}
