import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final Widget? bottomNav;
  final Widget? floatingButton;
  final PreferredSizeWidget? appbar;

  const BaseLayout({
    super.key,
    required this.body,
    this.bottomNav,
    this.floatingButton,
    this.appbar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('baseLayoutScaffold'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appbar,
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
      floatingActionButton: floatingButton,
      bottomNavigationBar: bottomNav,
    );
  }
}
