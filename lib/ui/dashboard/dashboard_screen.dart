import 'package:flutter/material.dart';
import 'package:htf_artesanos/ui/dashboard/new_product_form.dart';

import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/ui/art_pending/art_pending_page.dart';
import 'package:htf_artesanos/ui/art_products/art_products_page.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const ArtPendingPage(),
    const ArtProductsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: _pages[_selectedIndex],
      floatingButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const NewProductForm();
                  },
                );
              },
              child: const Icon(
                Icons.add,
                color: customSageGreen,
              ),
            )
          : null,
      bottomNav: BottomNavigationBar(
        backgroundColor: customBrown,
        selectedItemColor: customSageGreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pending),
            label: "Pendientes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: "Mis Productos",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}
