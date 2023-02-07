import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:track_my_job/services/pdf_generator/pdf_generator.dart';
import 'controllers/connectivity_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/constants/app_keys.dart';
import 'core/bindings/app_bindings.dart';
import 'controllers/localization_controller.dart';
import 'localization/translations.dart';
import 'routing/app_router.dart';
import 'core/theme/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Uncomment this line and make sure to replace fake repositories with remote repositories
  /// in the app_bindings.dart file and use your connection string in order to connect to MongoDb

  // await MongoDbAPI.init();

  await PdfGenerator.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  LocalizationController get langController =>
      Get.put(LocalizationController());
  ConnectivityController get _connectivityController => Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _connectivityController.listenAndAct(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        initialBinding: AppBindings(),
        translations: AppContent(),
        locale:
            Locale(langController.prefLang ?? Get.deviceLocale!.languageCode),
        fallbackLocale: Locale('en'),
        title: 'Track My Job Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeController.getTheme(),
        darkTheme: CustomTheme.darkTheme,
        scaffoldMessengerKey: kGlobaMessengerKey,
        navigatorKey: kGlobaNavigatorKey,
        getPages: AppRoutes().allPages,
        localizationsDelegates: const [
          MonthYearPickerLocalizations.delegate,
        ],
      ),
    );
  }
}
