class AuthService {
  Future<bool> login(String user, String pass) async {
    await Future.delayed(Duration(seconds: 1)); // simulasi API

    // fake validation rule
    if (user.isNotEmpty && pass.isNotEmpty) {
      return true;
    }

    return false;
  }
}