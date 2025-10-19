import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/store_cubit.dart';

class StoreSearchWidget extends StatefulWidget {
  const StoreSearchWidget({super.key});

  @override
  State<StoreSearchWidget> createState() => _StoreSearchWidgetState();
}

class _StoreSearchWidgetState extends State<StoreSearchWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade400),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/svg/Search Icon.svg',
              width: 24.w,
              height: 24.h,
              color: Colors.green.shade700,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  context.read<StoreCubit>().searchSupplies(value);
                  setState(() {}); // Trigger rebuild to show/hide clear button
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'search_medical_supplies'.tr(),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            if (_controller.text.isNotEmpty)
              IconButton(
                onPressed: () {
                  _controller.clear();
                  context.read<StoreCubit>().clearSearch();
                  setState(() {}); // Trigger rebuild to hide clear button
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey.shade400,
                  size: 20.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
