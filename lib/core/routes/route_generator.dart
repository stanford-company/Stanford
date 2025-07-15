import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medapp/presentation/main_home/pages/about_us.dart';
import 'package:medapp/presentation/medical_entity/pages/medical_details.dart';

import '../../data/medical_entity/model/medical_doctor.dart';
import '../../data/medical_entity/model/medical_entity.dart';
import '../../data/store/model/supplies_model.dart';
import '../../presentation/cart/bloc/cart_cubit.dart';
import '../../presentation/category_network/pages/step1/health_concern_page.dart';
import '../../presentation/main_home/pages/home.dart';
import '../../pages/language/change_laguage_page.dart';
import '../../pages/notifications/notification_settings_page.dart';
import '../../pages/notifications/notifications_page.dart';
import '../../pages/splash_page.dart';
import '../../presentation/auth/pages/check_id.dart';
import '../../presentation/auth/pages/login.dart';
import '../../presentation/category/pages/step1/health_concern_page.dart';
import '../../presentation/city/pages/city_page.dart';
import '../../presentation/medical_entity/pages/all_medicals.dart';
import '../../presentation/medical_entity/pages/step2/choose_doctor_page.dart';
import '../../presentation/procedures/bloc/procedures_cubit.dart';
import '../../presentation/search/pages/search_page.dart';
import '../../presentation/suggestions/bloc/suggestions_cubit.dart';
import '../../presentation/suggestions/pages/suggestions_page.dart';
import '../../presentation/store/pages/product_details.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());

      case Routes.signup:
        final args = settings.arguments as bool? ?? false;
        return CupertinoPageRoute(
          builder: (_) => CheckIdPage(isForgetPassword: args),
        );

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => Home());

      case Routes.procedures:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ProcedureCubit()..fetchProcedure(),
            // child: const ProcedureListPage(),
          ),
        );

      case Routes.suggestions:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SuggestionsCubit(),
            child: SuggestionsPage(),
          ),
        );
      case Routes.medicalNetwork:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SuggestionsCubit(),
            child: CategoryNetworkPage(),
          ),
        );
      case Routes.bookingStep1:
        return CupertinoPageRoute(
          builder: (_) => HealthConcernPage(),
          fullscreenDialog: true,
        );

      case Routes.bookingStep2:
        final args = settings.arguments as String? ?? "";
        return CupertinoPageRoute(
          builder: (_) => ChooseDoctorPage(cityId: args),
        );

      case Routes.bookingStepCity:
        return CupertinoPageRoute(builder: (_) => CityPage());

      case Routes.changeLanguage:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case Routes.notificationSettings:
        return CupertinoPageRoute(builder: (_) => NotificationSettingsPage());

      case Routes.productDetails:
        final args = settings.arguments as SuppliesModel;

        return CupertinoPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CartCubit(),
            child: ProductDetailsScreen(suppliesModel: args),
          ),
        );


        return CupertinoPageRoute(
          builder: (_) => ProductDetailsScreen(suppliesModel: args),
        );

      case Routes.search:
        return CupertinoPageRoute(builder: (_) => SearchPage());
      case Routes.medicalDetails:
        final args = settings.arguments;

        if (args is MedicalEntityModel) {
          return CupertinoPageRoute(
            builder: (_) => MedicalDetailsScreen(medicalEntity: args),
          );
        } else if (args is MedicalModel) {
          // Convert MedicalModel to MedicalEntityModel if needed
          return CupertinoPageRoute(
            builder: (_) => MedicalDetailsScreen(medicalModel: args),
          );
        } else {
          throw Exception('Unexpected argument type: ${args.runtimeType}');
        }

      case Routes.notifications:
        return CupertinoPageRoute(
          builder: (_) => NotificationsPage(),
          fullscreenDialog: true,
          maintainState: true,
        );
      case Routes.aboutUs:
        return CupertinoPageRoute(
          builder: (_) => AboutUsPage(),
          fullscreenDialog: true,
          maintainState: true,
        );
      case Routes.allMedical:
        final args = settings.arguments as List<MedicalModel>;
        return CupertinoPageRoute(
          builder: (_) => AllMedicalsPage(medicalDoctors: args),
          fullscreenDialog: true,
          maintainState: true,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text('Error')),
        );
      },
    );
  }
}
