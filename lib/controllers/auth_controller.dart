import 'package:getx_countries_app/services/storage_service.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
// class AuthController extends GetxController
//     with StateMixin<void> {

//   final AuthService _service = AuthService();

//   @override
//   void onInit() {
//     change(null, status: RxStatus.success());
//     super.onInit();
//   }

//   Future<void> login(String user, String pass) async {

//     change(null, status: RxStatus.loading());

//     try {

//       final result = await _service.login(user, pass);

//       if (result) {

//         await StorageService.saveLogin(user);

//         change(null, status: RxStatus.success());

//         Get.offAllNamed('/home');

//       } else {

//         change(
//           null,
//           status: RxStatus.error(
//             "Invalid credentials",
//           ),
//         );
//       }

//     } catch (e) {

//       change(
//         null,
//         status: RxStatus.error(
//           "Something went wrong",
//         ),
//       );
//     }
//   }
// }



class AuthController extends GetxController
    with StateMixin<void> {

  final AuthService _service = AuthService();

  final RxnString errorMessage = RxnString();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  Future<void> login(
    String user,
    String pass,
  ) async {

    change(null, status: RxStatus.loading());

    try {

      final result = await _service.login(
        user,
        pass,
      );

      if (result) {

        await StorageService.saveLogin(user);

        change(null, status: RxStatus.success());

        Get.offAllNamed('/home');

      } else {

        errorMessage.value =
            "Invalid credentials";

        change(
          null,
          status: RxStatus.success(),
        );
      }

    } catch (e) {

      errorMessage.value =
          "Something went wrong";

      change(
        null,
        status: RxStatus.success(),
      );
    }
  }
}