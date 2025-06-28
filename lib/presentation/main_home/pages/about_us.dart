import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/about_us_cubit.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  Future<void> _callCompany(String phoneNumber) async {
    if (phoneNumber.trim().isEmpty) {
      debugPrint('Phone number is empty');
      return;
    }

    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $uri');
    }
  }



  void _mailCompany(String mail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail, // Replace with your email
      query: Uri.encodeFull('subject=استفسار&body=مرحبا،'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email client';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about_us'.tr())),
      body: BlocBuilder<AboutUsCubit, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AboutUsLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Company Logo
                  Center(child: Image.asset('assets/images/launcher_ic.png')),
                  const SizedBox(height: 20),
                  Text(
                    context.locale.languageCode == 'en'
                        ? state.aboutUsModel.addressEn
                        : state.aboutUsModel.addressAr,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Phone number
                  GestureDetector(
                    onTap: () => _mailCompany("${state.aboutUsModel.email}"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mail, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          state.aboutUsModel.email,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _callCompany(state.aboutUsModel.phone1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          state.aboutUsModel.phone1,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sub Companies (horizontal ListView)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'liaison_officers'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.aboutUsModel.officers.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return Container(
                          // width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.green),
                            color: AppColors.light_grey_color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                context.locale.languageCode == 'en'
                                    ? state.aboutUsModel.officers[index].nameEn
                                    : state.aboutUsModel.officers[index].nameAr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context.locale.languageCode == 'en'
                                    ? state
                                          .aboutUsModel
                                          .officers[index]
                                          .addressEn
                                    : state
                                          .aboutUsModel
                                          .officers[index]
                                          .addressAr,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () => _callCompany(
                                  state
                                      .aboutUsModel
                                      .officers[index]
                                      .phoneNumber,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      state
                                          .aboutUsModel
                                          .officers[index]
                                          .phoneNumber,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
