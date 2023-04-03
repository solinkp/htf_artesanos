import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/utils/constants/global.dart';
import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/ui/widgets/preorder_button.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final int userType;

  const ProductItem({
    super.key,
    required this.product,
    this.userType = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(5.0.w),
      child: GestureDetector(
        onTap: () => context.router.push(ProductDetail(
          product: product,
          userType: userType,
        )),
        child: Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: customGrey,
          child: Column(
            children: [
              Hero(
                tag: '$productTag-${product.id}',
                child: Container(
                  width: double.infinity,
                  height: userType == 0 ? 45.h : 65.h,
                  margin: EdgeInsets.all(5.0.w),
                  decoration: BoxDecoration(
                    color: customBrown,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: customSageGreen, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(17)),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: NetworkImage(product.thumbnail),
                      image: NetworkImage(product.thumbnail),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '\$${product.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9.sp),
                    ),
                    if (userType == 1)
                      Expanded(
                        child: Center(
                          child: PreorderButton(productId: product.id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
