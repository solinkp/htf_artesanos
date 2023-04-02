import 'package:flutter/material.dart';

import 'package:htf_artesanos/utils/constants/global.dart';

void showMsnSnackbar(String message) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(content: Text(message)),
  );
}
