import 'package:codecarrots_unotraders/provider/bazaar_provider.dart';
import 'package:codecarrots_unotraders/provider/current_user_provider.dart';
import 'package:codecarrots_unotraders/provider/customer_job_actions_provider.dart';
import 'package:codecarrots_unotraders/provider/dashbord_provider.dart';
import 'package:codecarrots_unotraders/provider/home_provider.dart';
import 'package:codecarrots_unotraders/provider/image_pick_provider.dart';
import 'package:codecarrots_unotraders/provider/job_provider.dart';
import 'package:codecarrots_unotraders/provider/location_provider.dart';
import 'package:codecarrots_unotraders/provider/message_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_insights_provider.dart';
import 'package:codecarrots_unotraders/provider/profile_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_category_provider.dart';
import 'package:codecarrots_unotraders/provider/trader_job_info_provider.dart';
import 'package:codecarrots_unotraders/utils/router_class.dart';
import 'package:codecarrots_unotraders/screens/auth/login.dart';
import 'package:codecarrots_unotraders/screens/ui/splashscreen/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

SharedPreferences? sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  sp = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return HomeProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return BazaarProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return JobProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return LocationProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return TraderCategoryProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return ImagePickProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return ProfileProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CustomerJobActionProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return TraderInfoProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return DashbordProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CurrentUserProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return MessageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return ProfileInsightsProvider();
          },
        ),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: false,
        routes: {"login": (context) => LoginScreen()},
        debugShowCheckedModeBanner: false,
        title: 'UNO Traders',
        onGenerateRoute: RouterClass.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1200,
                name: DESKTOP, scaleFactor: .5),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
