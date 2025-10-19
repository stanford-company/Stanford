import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/presentation/store/widget/store_search_widget.dart';
import 'package:medapp/presentation/store/widget/store_card.dart';
import '../../../core/constants/app_colors.dart';
import '../bloc/store_cubit.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StoreCubit()..getMedicalSupplies()),
      ],
      child: const StorePageContent(),
    );
  }
}

class StorePageContent extends StatelessWidget {
  const StorePageContent({super.key});

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'exit_app'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary_color,
                ),
              ),
              content: Text(
                'are_you_sure_you_want_to_exit'.tr(),
                style: TextStyle(fontSize: 16.sp),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'cancel'.tr(),
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'exit'.tr(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await _showExitConfirmationDialog(context);
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        // appBar: _buildAppBar(context),
        body: Column(
          children: [
            const StoreSearchWidget(),
            BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state is StoreSupplyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StoreSupplyLoaded) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        itemCount: state.displaySupplies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, index) {
                          final item = state.displaySupplies[index];
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
      ),
    );
  }
}
