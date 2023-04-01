import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/ui/artisan_main.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await _initIsar();

  runApp(const MyApp());
}

Future<void> _initIsar() async {
  IsarService.instance.openIsarSchemas();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => const ArtisanMain(),
      minTextAdapt: true,
      designSize: const Size(360, 640),
    );
  }
}
