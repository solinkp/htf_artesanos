import 'package:flutter/material.dart';

extension StringExtension on String {
  String? validateEmpty(BuildContext context) => (isEmpty) ? 'Requerido' : null;

  String? validateEmail(BuildContext context) {
    var regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return (isEmpty)
        ? 'Requerido'
        : (!regex.hasMatch(this))
            ? 'Correo no válido'
            : null;
  }
}
