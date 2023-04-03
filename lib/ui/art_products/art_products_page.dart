import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/user/isar_user.dart';
import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/ui/widgets/custom_loader.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
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
  late IsarUser _isarUser;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadUser();
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

  Future<void> _loadUser() async {
    var user = await IsarService.instance.getIsarUser();
    if (user != null) {
      setState(() {
        _isarUser = user;
      });
    }
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
                  crossAxisCount: _isarUser.userType == 0 ? 3 : 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductItem(
                    product: _products[index],
                    userType: _isarUser.userType,
                  );
                },
              )
            : const Center(
                child: Text('No hay productos'),
              );
  }
}
