import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocks/remember_me_bloc.dart';
import 'core/routes/route_generator.dart';
import 'core/routes/routes.dart';
import 'core/utils/setup_service.dart';
import 'core/utils/simple_bloc_observer.dart';
import 'core/utils/themebloc/theme_bloc.dart';
// Side Drawer
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  setUpServiceLocator();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set status bar color
      statusBarIconBrightness:
          Brightness.dark, // Set icons to dark for white background
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );
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
      child: BlocProvider(
        create: (context) => RememberMeBloc(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                builder: (context, child) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor:
                          Colors.transparent, // Make status bar transparent
                      statusBarIconBrightness: Brightness.dark, // Dark icons
                      systemNavigationBarColor:
                          Colors.white, // White navigation bar
                      systemNavigationBarIconBrightness:
                          Brightness.dark, // Dark nav icons
                    ),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child!,
                    ),
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
                supportedLocales: EasyLocalization.of(
                  context,
                )!.supportedLocales,
                locale: EasyLocalization.of(context)!.locale,
                debugShowCheckedModeBanner: false,
                theme: state.themeData.copyWith(
                  appBarTheme: AppBarTheme(
                    color: Colors.white, // White app bar background
                    elevation: 0, // No shadow
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ), // Black icons
                    titleTextStyle: TextStyle(
                      color: Colors.black, // Black title text
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  scaffoldBackgroundColor:
                      Colors.white, // White scaffold background
                ),
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
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
