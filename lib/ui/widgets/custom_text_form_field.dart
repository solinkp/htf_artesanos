import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final IconData? icon;
  final String? helperText;
  final bool obscured;
  final bool last;
  final int lines;
  final bool isNumber;
  final int? charLength;
  final bool isReadOnly;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final bool autofocus;
  final Function()? onEnter;
  final bool smallUi;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textController,
    this.icon,
    this.helperText,
    this.onTap,
    this.charLength,
    this.validator,
    this.lines = 1,
    this.obscured = false,
    this.last = false,
    this.isNumber = false,
    this.isReadOnly = false,
    this.autofocus = false,
    this.onEnter,
    this.smallUi = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      style: TextStyle(
        color: customBrown,
        fontSize: 16.sp,
      ),
      maxLines: widget.lines,
      maxLength: widget.charLength,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscured ? _passwordInvisible : widget.obscured,
      controller: widget.textController,
      inputFormatters: widget.isNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
            ]
          : null,
      validator: widget.validator,
      textInputAction:
          widget.last ? TextInputAction.done : TextInputAction.next,
      readOnly: widget.isReadOnly,
      onTap: widget.onTap,
      onEditingComplete: widget.onEnter,
      cursorColor: customBrown,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color: customBrown,
          fontWeight: FontWeight.bold,
        ),
        labelText: widget.hintText,
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
        errorStyle: TextStyle(color: customRed, fontSize: 16.sp),
        hintText: widget.obscured
            ? '************'
            : widget.keyboardType == TextInputType.emailAddress
                ? 'ejemplo@ejemplo.com'
                : widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        helperText: widget.helperText,
        prefixIcon: Icon(
          widget.icon,
          color: customBrown,
        ),
        suffixIcon: widget.obscured
            ? IconButton(
                icon: Icon(
                  _passwordInvisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: customBrown,
                ),
                onPressed: () => setState(
                  () => _passwordInvisible = !_passwordInvisible,
                ),
              )
            : null,
      ),
    );
  }
}
