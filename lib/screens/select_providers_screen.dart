import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/suppliers_provider.dart';
import 'recharge_screen.dart';

class SelectProviderScreen extends ConsumerStatefulWidget {
  @override
  _SelectProviderScreenState createState() => _SelectProviderScreenState();
}

class _SelectProviderScreenState extends ConsumerState<SelectProviderScreen> {
  String? selectedProviderId;
  String? selectedProviderName;

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(suppliersProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Seleccionar Proveedor")),
      body: Center(
        child: suppliersAsync.when(
          data: (suppliers) {
            if (suppliers == null || suppliers.isEmpty) {
              return Text("No hay proveedores disponibles");
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text("Selecciona un proveedor"),
                    value: selectedProviderId,
                    items:
                        suppliers.map<DropdownMenuItem<String>>((provider) {
                          return DropdownMenuItem<String>(
                            value: provider["id"],
                            child: Text(provider["name"]),
                            onTap: () {
                              setState(() {
                                selectedProviderName = provider["name"];
                              });
                            },
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProviderId = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        selectedProviderId != null
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => RechargeScreen(
                                        providerId: selectedProviderId!,
                                        providerName:
                                            selectedProviderName ?? "Proveedor",
                                      ),
                                ),
                              );
                            }
                            : null,
                    child: Text("Continuar con la Recarga"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/history');
                    },
                    child: Text("Ver Historial de Recargas"),
                  ),
                ],
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
