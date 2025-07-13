// ✅ ProductDetailsScreen with BlocListener for CartCubit
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';

import '../../../data/store/model/supplies_model.dart';
import '../../cart/bloc/cart_cubit.dart';
import '../../cart/pages/cart_storage.dart';

class ProductDetailsScreen extends StatefulWidget {
  final SuppliesModel suppliesModel;

  const ProductDetailsScreen({super.key, required this.suppliesModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state is CartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order created successfully')),
          );
          Navigator.pop(context);
        } else if (state is CartFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  widget.suppliesModel.images[selectedImageIndex].imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.suppliesModel.images.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedImageIndex = index);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedImageIndex == index ? Colors.green : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            widget.suppliesModel.images[index].imageUrl,
                            width: 50,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Color(0xff80D5B5),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: AppColors.green,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'currently_available'.tr(),
                              style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.suppliesModel.price} JOD',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          context.locale.languageCode == "en"
                              ? widget.suppliesModel.nameEn ?? ""
                              : widget.suppliesModel.nameAr ?? "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xff13434A),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() => quantity++);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.green,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(),
                    const SizedBox(height: 12),
                    Text(
                      'product_details'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      context.locale.languageCode == "en"
                          ? widget.suppliesModel.descriptionEn ?? ""
                          : widget.suppliesModel.descriptionAr ?? "",
                      style: TextStyle(
                        color: Color(0xff6A717E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 360.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF29A07B), Color(0xFF1B8064)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        border: Border.all(color: Color(0xFF156752), width: 1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x80156752),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0x66FFFFFF),
                            offset: Offset(0, 2),
                            blurRadius: 0,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () async {
                          final item = {
                            'medical_supply_id': widget.suppliesModel.id,
                            'quantity': quantity,
                            'price': double.tryParse(widget.suppliesModel.price.toString()) ?? 0.0,
                            'name_en': widget.suppliesModel.nameEn,
                            'name_ar': widget.suppliesModel.nameAr,
                            'image_url': widget.suppliesModel.images.isNotEmpty
                                ? widget.suppliesModel.images[0].imageUrl
                                : '',
                          };

                          final cartItems = await CartStorage.loadCartItems();
                          cartItems.add(item);
                          await CartStorage.saveCartItems(cartItems);


                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item added to cart')),
                          );
                          Navigator.pop(context);
                        },

                        // onTap: () {
                        //   final phone = '07999999999999';
                        //   final items = [
                        //     {
                        //       'medical_supply_id': widget.suppliesModel.id,
                        //       'quantity': quantity,
                        //       'price': double.tryParse(widget.suppliesModel.price.toString()) ?? 0.0,
                        //     }
                        //   ];
                        //   context.read<CartCubit>().createOrder(phone: phone, items: items);
                        // },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 32,
                          ),
                          child: Center(
                            child: Text(
                              'book_now'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
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
