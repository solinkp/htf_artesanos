import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/cart/cart.dart';
import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/ui/widgets/custom_loader.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/ui/shopping_cart/widgets/shop_cart_item.dart';
import 'package:htf_artesanos/utils/custom_snackbar.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  Cart? _cart;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
    });

    final data = await ApiArtisanService.instance.getCart();
    if (data != null) {
      setState(() {
        _cart = data;
        _isLoading = false;
      });
    } else {
      final localData = await IsarService.instance.getIsarCart();
      if (localData != null) {
        setState(() {
          _cart = Cart.fromJson(localData.toMap(localData));
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appbar: AppBar(title: const Text('Mi carrito')),
      body: _isLoading
          ? const Center(
              child: CustomLoader(
                size: SpinnerSize.normal,
              ),
            )
          : _cart == null || _cart!.products.isEmpty
              ? const Center(child: Text('No hay productos en tu carrito'))
              : Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _cart!.products.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: ShopCartItem(
                              product: _cart!.products[index],
                              callback: _loadCart,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: customBrown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            _totalCart(
                              'Total Productos',
                              '${_cart!.totalProducts}',
                            ),
                            _totalCart(
                              'Total Cantidad',
                              '${_cart!.totalQuantity}',
                            ),
                            _totalCart(
                              'Total',
                              '\$${_cart!.total}',
                            ),
                            _totalCart(
                              'Total Descontado',
                              '\$${_cart!.discountedTotal}',
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: customGrey,
                                ),
                                onPressed: _verifySend,
                                child: const Text(
                                  'Confirmar Reserva',
                                  style: TextStyle(color: customBrown),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _totalCart(String title, String data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$title:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            flex: 2,
            child: Text(
              data,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _verifySend() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Confirmar Reserva',
            style: TextStyle(color: customBrown),
          ),
          content: const Text(
            '¿Deseas proceder con tu reserva?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _sendPreorder();
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _sendPreorder() async {
    // send preorder to api
    for (var product in _cart!.products) {
      await ApiArtisanService.instance.addTodo(
        'Reserva de producto: ${product.title}',
      );
    }
    // remove cart api
    await ApiArtisanService.instance.removeCart(_cart!.id);
    // remove cart locally
    await IsarService.instance.clearIsarCart();
    showMsnSnackbar('Tu reserva se ha enviado correctamente');
    if (mounted) context.router.pop();
  }
}
