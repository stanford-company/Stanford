import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medapp/presentation/category/bloc/category_cubit.dart';
import '../../../../common/components/health_concern_item.dart';
import '../../../../core/routes/routes.dart';
import '../../../../data/category/model/category.dart';
import '../../../../data/category/service/category.dart';

class HealthConcernPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => CategoryCubit()..getCategories(),
  child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('book_an_appointment'.tr()),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body:  BlocBuilder<CategoryCubit, CategoryState>(
  builder: (context, state) {
    if(state is CategoryLoaded)
    return Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'choose_health_concern'.tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  MasonryGridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      return HealthConcernItem(
                        healthCategory: state.categories[index],
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.bookingStep2);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      );
    return SizedBox();
  },
),
    ),
);
  }
}
