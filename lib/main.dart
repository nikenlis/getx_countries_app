import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_countries_app/services/storage_service.dart';
import 'package:toastification/toastification.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkTheme,
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
      ),
    );
  }
}
