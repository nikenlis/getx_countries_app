import 'package:get/get.dart';
import 'package:getx_countries_app/app/routes/app_routes.dart';

import '../../views/login_page.dart';
import '../binding/auth_binding.dart';

class AppPages {
  static const initial = Routes.login;

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
  ];
}