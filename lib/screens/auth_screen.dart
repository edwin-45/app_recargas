import 'package:app_recargas/screens/select_providers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends ConsumerWidget {
  final TextEditingController userController = TextEditingController(
    text: "user0147",
  );
  final TextEditingController passController = TextEditingController(
    text: "#3Q34Sh0NlDS",
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Autenticación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(authProvider.notifier)
                    .login(userController.text, passController.text);

                // Si la autenticación fue exitosa, navegar a la pantalla de selección de proveedor
                if (ref.read(authProvider) != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectProviderScreen(),
                    ),
                  );
                }
              },
              child: Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
