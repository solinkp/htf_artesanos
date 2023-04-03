import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/custom_snackbar.dart';
import 'package:htf_artesanos/ui/widgets/preorder_alert.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
import 'package:htf_artesanos/domain/product/product_cart_dto.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';

class PreorderButton extends StatelessWidget {
  final int productId;
  final bool minSize;

  const PreorderButton({
    super.key,
    required this.productId,
    this.minSize = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: !minSize ? 30.h : 22.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PreorderAlert(preorderQuantity: _preorderProductQuantity);
            },
          );
        },
        child: const Text('Reservar'),
      ),
    );
  }

  Future<void> _preorderProductQuantity(int quantity) async {
    var product = ProductCartDTO(id: productId, quantity: quantity);
    var cartResult = await ApiArtisanService.instance.addProductToCart(product);
    await IsarService.instance.saveIsarCart(cartResult);
    showMsnSnackbar('Producto agregado a tu carrito');
  }
}
