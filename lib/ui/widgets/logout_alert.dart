import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cierre de sesión'),
      content: const Text('¿Está seguro que desea cerrar la sesión?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            await IsarService.instance.clearIsarUser();
            // ignore: use_build_context_synchronously
            context.router.pushAndPopUntil(const Login(),
                predicate: (Route<dynamic> route) => false);
          },
          child: const Text('Completar'),
        ),
      ],
    );
  }
}
