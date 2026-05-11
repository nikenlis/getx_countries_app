import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_countries_app/services/storage_service.dart';
import 'package:toastification/toastification.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  final isLoggedIn = StorageService.isLoggedIn();

  runApp(App(isLoggedIn: isLoggedIn));
}

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.darkTheme,
        initialRoute: isLoggedIn ? Routes.home : Routes.login,
        getPages: AppPages.pages,
      ),
    );
  }
}
