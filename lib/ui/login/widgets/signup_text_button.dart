
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class SignupTextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignupTextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '¿No tienes cuenta? Regístrate aquí!',
            style: TextStyle(
              color: customBrown,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
