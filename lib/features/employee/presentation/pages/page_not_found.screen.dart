import 'package:em/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Text(
        'Page not found',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.defaultSize * 4,
        ),
      ),
    );
  }
}
