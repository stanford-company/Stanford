import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/common/components/search_widget.dart';
import 'package:medapp/presentation/store/widget/store_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../cart/pages/cart_view.dart';
import '../bloc/store_cubit.dart';
import '../../cart/bloc/cart_cubit.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StoreCubit()..getMedicalSupplies()),
        BlocProvider(create: (_) => CartCubit()..loadCart()),
      ],
      child: const StorePageContent(),
    );
  }
}

class StorePageContent extends StatelessWidget {
  const StorePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SearchWidget(),
              BlocBuilder<StoreCubit, StoreState>(
                builder: (context, state) {
                  if (state is StoreSupplyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StoreSupplyLoaded) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          itemCount: state.supplies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                          itemBuilder: (context, index) {
                            final item = state.supplies[index];
                            return StoreCard(suppliesModel: item);
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),

          // Sticky Go to Checkout Button
          Positioned(
            bottom: 10.h,
            left: 16.w,
            right: 16.w,
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState is CartLoaded) {
                  return cartState.items.isEmpty
                      ? SizedBox.shrink()
                      : ElevatedButton.icon(
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Go to Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary_color,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const CartPage(phone: "0799999999"),
                              ),
                            );
                          },
                        );
                } else
                  return Container(width: 100, height: 100, color: Colors.red);
              },
            ),
          ),
        ],
      ),
    );
  }
}
