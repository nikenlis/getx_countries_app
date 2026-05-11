import 'package:getx_countries_app/services/storage_service.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';


class AuthController extends GetxController {
  final AuthService _service = AuthService();

  var isLoading = false.obs;

  Future<void> login(String user, String pass) async {
    isLoading.value = true;

    final result = await _service.login(user, pass);

    isLoading.value = false;

    if (result) {
      await StorageService.saveLogin(user);

      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }
}