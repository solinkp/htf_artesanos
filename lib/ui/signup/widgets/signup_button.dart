import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/ui/widgets/custom_loader.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class SignupButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SignupButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: customBrown,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? const CustomLoader(
                size: SpinnerSize.small,
                color: Colors.white,
              )
            : Align(
                alignment: Alignment.center,
                child: Text(
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
