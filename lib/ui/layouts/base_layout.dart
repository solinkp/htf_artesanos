import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('baseLayoutScaffold'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: customBrown,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: customBrown,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
