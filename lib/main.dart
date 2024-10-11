import 'package:coswan/firebase_options.dart';
import 'package:coswan/providers/addressprovider.dart';
import 'package:coswan/providers/cartprovider.dart';
import 'package:coswan/screens/splash_screen.dart';
import 'package:coswan/providers/distributor_order_provider.dart';
import 'package:coswan/providers/notificatiion_provider.dart';
import 'package:coswan/providers/userprovider.dart';
import 'package:coswan/providers/vendor_provider.dart';
import 'package:coswan/providers/whislist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("Token : $fcmToken");

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application in github.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(431, 932),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => VendorProvider()),
          ChangeNotifierProvider(
              create: (context) => DistributorOrderProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: ((context) => WhislistProvider())),
          ChangeNotifierProvider(create: (context) => AddressProvider())
        ],
        child: MaterialApp(
          theme: ThemeData(
            // to set the font family for all
            textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Inter'),
            // Optionally, set the primary font family for other text styles
            primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
                  fontFamily: 'Inter',
                ),

            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: Color.fromRGBO(144, 110, 16, 1),
                ),
                titleSpacing: -2,
                iconTheme:
                    IconThemeData(color: Color.fromRGBO(144, 110, 16, 1))),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(144, 110, 16, 1)),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
