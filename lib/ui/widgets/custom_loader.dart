import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

enum SpinnerSize { small, normal, big }

class CustomLoader extends StatelessWidget {
  final SpinnerSize size;
  final Color? color;

  const CustomLoader({
    super.key,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    const Key key = Key('spinkitLoader');
    final Color color = this.color ?? customBrown;
    late double size;

    switch (this.size) {
      case SpinnerSize.small:
        size = 30.w;
        break;
      case SpinnerSize.normal:
        size = 50.w;
        break;
      case SpinnerSize.big:
        size = 60.w;
        break;
      default:
        size = 30.w;
    }

    return Center(
      child: SpinKitCircle(
        key: key,
        color: color,
        size: size,
      ),
    );
  }
}
