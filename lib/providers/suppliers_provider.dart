import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

final suppliersProvider = FutureProvider<List<dynamic>?>((ref) async {
  final token = ref.watch(authProvider);
  if (token == null) {
    throw Exception('Usuario no autenticado');
  }
  final apiService = ApiService();
  return apiService.getSuppliers(token);
});
