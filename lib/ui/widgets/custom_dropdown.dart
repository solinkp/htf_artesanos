import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

class CustomDropdown extends StatefulWidget {
  final String? value;
  final String label;
  final List<DropdownMenuItem<String>> items;
  final IconData? icon;
  final Function(dynamic) validatorFunction;
  final Function(String?) setOnChangedValue;

  const CustomDropdown({
    Key? key,
    this.value,
    required this.label,
    required this.items,
    this.icon,
    required this.validatorFunction,
    required this.setOnChangedValue,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: DropdownButtonFormField(
        value: widget.value,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: customRed),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: customRed),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: customBrown,
            fontWeight: FontWeight.bold,
          ),
          errorStyle: TextStyle(color: customRed, fontSize: 16.sp),
          icon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: customBrown,
                )
              : null,
          filled: false,
        ),
        isExpanded: true,
        dropdownColor: customGrey,
        iconEnabledColor: customBrown,
        style: TextStyle(
          color: customBrown,
          fontSize: 16.sp,
          overflow: TextOverflow.clip,
        ),
        items: widget.items,
        validator: (value) => widget.validatorFunction(value),
        onChanged: widget.setOnChangedValue,
      ),
    );
  }
}
