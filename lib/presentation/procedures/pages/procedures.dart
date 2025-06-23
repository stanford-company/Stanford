import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/procedures_cubit.dart';
import '../bloc/procedures_state.dart';
import '../widget/pdf_view.dart';

class ProcedureListPage extends StatelessWidget {
  const ProcedureListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
        ),

        title: Text(
          'procedures'.tr(),
          style: TextStyle(
            color: Color(0xFF222B45),
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),

      body: BlocBuilder<ProcedureCubit, ProcedureState>(
        builder: (context, state) {
          if (state is ProcedureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProcedureLoaded) {
            final procedures = state.procedures;
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: procedures.length,
              itemBuilder: (context, index) {
                final procedure = procedures[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PdfViewerPage(url: procedure.pdfUrl),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16.w),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Color(0xfff3f3f6),
                      borderRadius: BorderRadius.circular(16.w),
                      border: Border.all(
                        color: Color(0xffe3e3eb),
                        width: 1.5.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: Color(0xFF2E7D32),
                              size: 28.w,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                context.locale.languageCode == 'en'
                                    ? procedure.titleEn
                                    : procedure.titleAr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF222B45),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.picture_as_pdf,
                              color: Colors.redAccent[200],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.locale.languageCode == 'en'
                              ? procedure.descriptionEn
                              : procedure.descriptionAr,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF8F9BB3),
                            height: 1.4.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProcedureError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
