import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:htf_artesanos/ui/router/router.gr.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.push(const ShoppingCart());
      },
      icon: const Icon(Icons.shopping_cart),
    );
  }
}
