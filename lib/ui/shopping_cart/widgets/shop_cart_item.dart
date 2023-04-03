import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
import 'package:htf_artesanos/domain/product/product_cart.dart';

class ShopCartItem extends StatelessWidget {
  final ProductCart product;
  final VoidCallback callback;

  const ShopCartItem({
    super.key,
    required this.product,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _checkRemoveFromCart(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: customBrown),
      ),
      contentPadding: EdgeInsets.only(left: 15.w, right: 5.w),
      title: Text(product.title),
      subtitle: IntrinsicHeight(
        child: Row(
          children: [
            Text('Descuento: ${product.discountPercentage}%'),
            const VerticalDivider(),
            Text('Cantidad: ${product.quantity}'),
          ],
        ),
      ),
      trailing: Container(
        width: 60.sp,
        height: 50.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: customBrown,
        ),
        child: Center(child: Text('\$${product.price}')),
      ),
    );
  }

  void _checkRemoveFromCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Remover producto',
            style: TextStyle(color: customBrown),
          ),
          content: const Text(
            '¿Deseas remover este producto de tu carrito de compras?',
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
                IsarService.instance.removeProductFromCart(product.id);
                callback();
                Navigator.of(context).pop();
              },
              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }
}
