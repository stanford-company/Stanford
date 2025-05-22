import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocks/remember_me_bloc.dart';
import 'routes/route_generator.dart';
import 'routes/routes.dart';
import 'utils/themebloc/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('it', 'IT'),
        Locale('pt', 'PT'),
        Locale('ar', 'SA'),
      ],
      path: 'assets/languages',
      child: BlocProvider(create: (context) => RememberMeBloc(), child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // iPhone X size as reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                builder: (context, child) {
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: child!,
                  );
                },
                title: 'Stanford',
                initialRoute: Routes.splash,
                onGenerateRoute: RouteGenerator.generateRoute,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  EasyLocalization.of(context)!.delegate,
                ],
                supportedLocales: EasyLocalization.of(context)!.supportedLocales,
                locale: EasyLocalization.of(context)!.locale,
                debugShowCheckedModeBanner: false,
                theme: state.themeData,
              );
            },
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
