import 'package:flutter/material.dart';

class GraficasDiasScreen extends StatelessWidget {
  const GraficasDiasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficas Días'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(width: double.infinity, height: 300, color: Colors.red),
            Container(width: double.infinity, height: 300, color: Colors.green),
            Container(
                width: double.infinity, height: 300, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
