import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/suppliers_provider.dart';

class SuppliersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(suppliersProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Proveedores')),
      body: Center(
        child: suppliersAsync.when(
          data:
              (suppliers) =>
                  suppliers != null
                      ? ListView.builder(
                        itemCount: suppliers.length,
                        itemBuilder: (context, index) {
                          final supplier = suppliers[index];
                          return ListTile(
                            title: Text(supplier["name"]),
                            subtitle: Text("ID: ${supplier["id"]}"),
                          );
                        },
                      )
                      : Text("No se encontraron proveedores"),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text("Error: $err"),
        ),
      ),
    );
  }
}
