import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, String?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null);

  final ApiService _apiService = ApiService();

  Future<void> login(String user, String password) async {
    final token = await _apiService.authenticate(user, password);
    if (token != null) {
      state = token;
    } else {
      // Manejo de error, por ejemplo, mostrar un mensaje de error en la UI
    }
  }
}
