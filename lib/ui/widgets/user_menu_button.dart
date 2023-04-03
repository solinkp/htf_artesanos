import 'package:flutter/material.dart';

import 'package:htf_artesanos/ui/widgets/logout_alert.dart';

class UserMenuButton extends StatelessWidget {
  const UserMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.person),
      onSelected: (_) {
        showDialog(
          context: context,
          builder: (context) {
            return const LogoutAlert();
          },
        );
      },
      itemBuilder: (_) {
        return [
          const PopupMenuItem(
            value: 0,
            child: Text('Cerrar sesión'),
          ),
        ];
      },
    );
  }
}
