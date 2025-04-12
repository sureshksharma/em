import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/size_config.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.onTap,
    required this.title,
  });
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.defaultSize * 1.6,
          color: AppTheme.colorBlack,
        ),
      ),
    );
  }
}
