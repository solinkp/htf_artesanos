import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/ui/widgets/custom_loader.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/ui/art_products/widgets/product_item.dart';

class ArtProductsPage extends StatefulWidget {
  const ArtProductsPage({super.key});

  @override
  State<ArtProductsPage> createState() => _ArtProductsPageState();
}

class _ArtProductsPageState extends State<ArtProductsPage> {
  List<Product> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });
    final data = await ApiArtisanService.instance.getArtisanProducts();
    setState(() {
      _products = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CustomLoader(
              size: SpinnerSize.normal,
            ),
          )
        : _products.isNotEmpty
            ? GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _products.length,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductItem(product: _products[index]);
                },
              )
            : const Center(
                child: Text('No cuentas con productos'),
              );
  }
}
