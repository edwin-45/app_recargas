import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';

class RechargeScreen extends StatefulWidget {
  final String providerId;
  final String providerName;

  RechargeScreen({required this.providerId, required this.providerName});

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool isLoading = false;
  String? transactionMessage;

  Future<void> _saveRecharge() async {
    final String phone = phoneController.text.trim();
    final int? amount = int.tryParse(amountController.text.trim());

    // Validaciones
    if (phone.isEmpty || !phone.startsWith("3") || phone.length != 10) {
      setState(() {
        transactionMessage = "Número de teléfono inválido.";
      });
      return;
    }

    if (amount == null || amount < 1000 || amount > 100000) {
      setState(() {
        transactionMessage = "El monto debe estar entre 1,000 y 100,000.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      transactionMessage = null;
    });

    final String fecha = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    final recarga = {
      "proveedor": widget.providerName,
      "telefono": phone,
      "monto": amount,
      "fecha": fecha,
    };

    await DatabaseHelper().insertRecarga(recarga);

    setState(() {
      isLoading = false;
      transactionMessage = "✅ Recarga guardada con éxito.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recarga - ${widget.providerName}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Número de Teléfono"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Monto"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _saveRecharge,
                  child: Text("Guardar Recarga"),
                ),
            SizedBox(height: 20),
            if (transactionMessage != null)
              Text(
                transactionMessage!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
