import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
import 'package:htf_artesanos/ui/dashboard/new_product_form.dart';
import 'package:htf_artesanos/ui/art_pending/art_pending_page.dart';
import 'package:htf_artesanos/ui/art_products/art_products_page.dart';

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
      appbar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.person),
            onSelected: (_) {
              _validateSignOut();
            },
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Cerrar sesión'),
                ),
              ];
            },
          ),
        ],
      ),
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

  void _validateSignOut() {
    showDialog(
      context: context,
      builder: (context) {
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
                if (mounted) {
                  context.router.pushAndPopUntil(const Login(),
                      predicate: (Route<dynamic> route) => false);
                }
              },
              child: const Text('Completar'),
            ),
          ],
        );
      },
    );
  }
}
