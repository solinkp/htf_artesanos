import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(5.0.w),
      child: GestureDetector(
        onTap: () {},
        child: Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: customGrey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 45.h,
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
              Expanded(
                child: Column(
                  children: [
                    Text(
                      product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      '\$${product.price}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.sp),
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
