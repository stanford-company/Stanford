import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medapp/common/components/search_widget.dart';
import 'package:medapp/presentation/store/widget/store_card.dart';

import '../../../common/bloc/bottom_bar_cubit.dart';
import '../../../core/routes/routes.dart';
import '../bloc/store_cubit.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..getMedicalSupplies(),
      child: Column(
        children: [
          SearchWidget(),

          BlocBuilder<StoreCubit, StoreState>(
            builder: (context, state) {
              if (state is StoreSupplyLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is StoreSupplyLoaded)
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: state.supplies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
