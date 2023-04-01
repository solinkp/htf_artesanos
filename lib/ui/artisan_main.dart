import 'package:flutter/material.dart' hide Router;

import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/ui/router/guards/auth_guard.dart';

final appRouter = AppRouter(
  checkIfUserIsAuthenticated: CheckIfUserIsAuthenticated(),
);

class ArtisanMain extends StatelessWidget {
  const ArtisanMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Browa',
        scaffoldBackgroundColor: customLightGrey,
      ),
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaleFactor: media.textScaleFactor.clamp(1.0, 1.3),
          ),
          child: child!,
        );
      },
      onGenerateTitle: (context) => 'Guía Artesanos',
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
