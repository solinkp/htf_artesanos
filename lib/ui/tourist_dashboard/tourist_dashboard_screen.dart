import 'package:flutter/material.dart';

import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/ui/widgets/user_menu_button.dart';
import 'package:htf_artesanos/ui/art_products/art_products_page.dart';
import 'package:htf_artesanos/ui/tourist_dashboard/widgets/shopping_cart_button.dart';

class TouristDashboardScreen extends StatelessWidget {
  const TouristDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appbar: AppBar(
        actions: const [
          ShoppingCartButton(),
          UserMenuButton(),
        ],
      ),
      body: const ArtProductsPage(),
    );
  }
}
