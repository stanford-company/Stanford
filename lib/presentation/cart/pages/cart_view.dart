import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/core/constants/app_colors.dart';
import '../../store/widget/success_order.dart';
import '../bloc/cart_cubit.dart';

class CartPage extends StatelessWidget {
  final String phone;

  const CartPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..loadCart(),
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: const Text(
              'Your Cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary_color,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return const Center(child: Text("Your cart is empty 🛒"));
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),

                      // CartPage widget...
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final name =
                            item['name_en'] ??
                            item['name_ar'] ??
                            item['name'] ??
                            'Unnamed';
                        final imageUrl =
                            item['image_url'] ?? item['image'] ?? '';
                        final quantity = item['quantity'];
                        final price =
                            (item['price'] ?? 0.0) * (item['quantity'] ?? 1);
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF113F4E),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Quantity: $quantity",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  children: [
                                    Text(
                                      "$price JOD",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF1B8064),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        context.read<CartCubit>().removeItem(
                                          index,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const Divider(thickness: 1),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final cubit = context.read<CartCubit>();
                          await cubit.createOrder(phone: phone, items: items);

                          final currentState = cubit.state;
                          if (currentState is CartSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SuccessOrderPage(),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: Text(
                          "Complete Checkout",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary_color,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else
              return Container(width: 100, height: 100, color: Colors.red);
          },
        ),
      ),
    );
  }
}
