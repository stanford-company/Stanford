import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../../data/store/model/supplies_model.dart';
import '../../cart/bloc/cart_cubit.dart';

class StoreCard extends StatelessWidget {
  final SuppliesModel suppliesModel;
  const StoreCard({super.key, required this.suppliesModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: suppliesModel,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Color(0xfff3f3f6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  suppliesModel.images[0].imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      context.locale.languageCode == "en"
                          ? suppliesModel.nameEn ?? ""
                          : suppliesModel.nameAr ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff113F4E),
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${suppliesModel.price} JD',
                    style: TextStyle(
                      color: Color(0xff1B8064),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      int itemQuantity = 0;

                      if (state is CartLoaded) {
                        final existingItem = state.items.firstWhere(
                          (item) =>
                              item['medical_supply_id'] == suppliesModel.id,
                          orElse: () => {},
                        );
                        itemQuantity = existingItem['quantity'] ?? 0;
                      }

                      if (itemQuantity == 0) {
                        // Show Add to Cart button
                        return SizedBox(
                          width: double.infinity,
                          height: 24.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              final item = {
                                'medical_supply_id': suppliesModel.id,
                                'quantity': 1,
                                'price':
                                    double.tryParse(
                                      suppliesModel.price.toString(),
                                    ) ??
                                    0.0,
                                'name_en': suppliesModel.nameEn,
                                'name_ar': suppliesModel.nameAr,
                                'image_url': suppliesModel.images.isNotEmpty
                                    ? suppliesModel.images[0].imageUrl
                                    : '',
                              };
                              await context.read<CartCubit>().addToCart(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('item_added_to_cart'.tr()),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Text(
                              'add_to_cart'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Show quantity controls
                        return Container(
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final item = {
                                    'medical_supply_id': suppliesModel.id,
                                    'quantity': -1,
                                    'price':
                                        double.tryParse(
                                          suppliesModel.price.toString(),
                                        ) ??
                                        0.0,
                                    'name_en': suppliesModel.nameEn,
                                    'name_ar': suppliesModel.nameAr,
                                    'image_url': suppliesModel.images.isNotEmpty
                                        ? suppliesModel.images[0].imageUrl
                                        : '',
                                  };
                                  await context.read<CartCubit>().addToCart(
                                    item,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                              Text(
                                '$itemQuantity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final item = {
                                    'medical_supply_id': suppliesModel.id,
                                    'quantity': 1,
                                    'price':
                                        double.tryParse(
                                          suppliesModel.price.toString(),
                                        ) ??
                                        0.0,
                                    'name_en': suppliesModel.nameEn,
                                    'name_ar': suppliesModel.nameAr,
                                    'image_url': suppliesModel.images.isNotEmpty
                                        ? suppliesModel.images[0].imageUrl
                                        : '',
                                  };
                                  await context.read<CartCubit>().addToCart(
                                    item,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
