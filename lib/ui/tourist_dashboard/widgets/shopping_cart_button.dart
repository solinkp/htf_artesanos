import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // context.router.push(ShoppingCart());
      },
      icon: const Icon(Icons.shopping_cart),
    );
  }
}
