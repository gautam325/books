import 'package:books/model/app_user.dart';
import 'package:books/routes/app_routes.dart';
import 'package:books/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final Rxn<AppUser> currentUser = Rxn<AppUser>();
  final isLoading = false.obs;

  bool get isLoggedIn => currentUser.value != null;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    currentUser.value = await _authService.login(email, password);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;
    currentUser.value = await _authService.register(name, email, password);
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.home);
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}
