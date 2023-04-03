import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/ui/widgets/preorder_button.dart';
import 'package:htf_artesanos/utils/constants/global.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class ProductDetailScrenn extends StatelessWidget {
  final Product product;
  final int userType;

  const ProductDetailScrenn({
    super.key,
    required this.product,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appbar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Hero(
            tag: '$productTag-${product.id}',
            child: SizedBox(
              width: double.infinity,
              height: 180.h,
              child: Swiper(
                itemCount: product.images.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                loop: true,
                pagination: const SwiperPagination(),
                itemBuilder: (context, index) => FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: NetworkImage(product.images[index]),
                  image: NetworkImage(product.images[index]),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: customBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _bulletPoint('Marca: ${product.brand}'),
                    _bulletPoint(
                      'Precio: \$${product.price.toStringAsFixed(2)}',
                    ),
                    _bulletPoint('Inventario: ${product.stock}'),
                  ],
                ),
              ),
            ),
          ),
          if (userType == 1)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PreorderButton(productId: product.id, minSize: false),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bulletPoint(String description) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            color: customBrown,
            size: 18,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14.sp,
                color: customBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
