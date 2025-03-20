import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _recargas = [];

  @override
  void initState() {
    super.initState();
    _loadRecargas();
  }

  Future<void> _loadRecargas() async {
    final data = await DatabaseHelper().getRecargas();
    setState(() {
      _recargas = data;
    });
  }

  Future<void> _clearHistory() async {
    await DatabaseHelper().deleteAllRecargas();
    _loadRecargas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Recargas"),
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: _clearHistory),
        ],
      ),
      body:
          _recargas.isEmpty
              ? Center(child: Text("No hay recargas guardadas"))
              : ListView.builder(
                itemCount: _recargas.length,
                itemBuilder: (context, index) {
                  final recarga = _recargas[index];
                  return ListTile(
                    title: Text("Proveedor: ${recarga["proveedor"]}"),
                    subtitle: Text(
                      "Tel: ${recarga["telefono"]} - ${recarga["fecha"]}",
                    ),
                    trailing: Text("\$${recarga["monto"]}"),
                  );
                },
              ),
    );
  }
}
