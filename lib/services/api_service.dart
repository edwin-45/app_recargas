import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://us-central1-puntored-dev.cloudfunctions.net/technicalTest-developer/api',
    ),
  );

  // Clave de API para autenticación
  final String _apiKey =
      'mtrQF6Q11eosqyQnkMY0JGFbGqcxVg5icvfVnX1ifIyWDvwGApJ8WUM8nHVrdSkN';

  /// Autenticación: obtiene el token "Bearer"
  Future<String?> authenticate(String user, String password) async {
    try {
      final response = await _dio.post(
        '/auth',
        data: {'user': user, 'password': password},
        options: Options(headers: {'x-api-key': _apiKey}),
      );
      // Se espera que el token venga en response.data['token']
      return response.data['token'];
    } catch (e) {
      print('Error en autenticación: $e');
      return null;
    }
  }

  /// Obtiene la lista de proveedores de recargas
  Future<List<dynamic>?> getSuppliers(String token) async {
    try {
      final response = await _dio.get(
        '/getSuppliers',
        options: Options(headers: {'authorization': token}),
      );
      return response.data; // Se espera una lista de proveedores
    } catch (e) {
      print('Error al obtener proveedores: $e');
      return null;
    }
  }

  /// Realiza la compra de la recarga
  /// [purchaseData] debe contener los datos necesarios, por ejemplo:
  /// { "phone": "3XXXXXXXXX", "amount": 5000, "supplierId": "8753" }
  Future<Map<String, dynamic>?> buy(
    String token,
    Map<String, dynamic> purchaseData,
  ) async {
    try {
      final response = await _dio.post(
        '/buy',
        data: purchaseData,
        options: Options(headers: {'authorization': token}),
      );
      return response
          .data; // Se espera que devuelva el ticket o resumen de la compra
    } catch (e) {
      print('Error al realizar la compra: $e');
      return null;
    }
  }
}
