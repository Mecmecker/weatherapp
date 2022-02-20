import 'package:flutter/material.dart';
import 'package:weatherapp/models/models.dart';

class GraficasHorasScreen extends StatelessWidget {
  const GraficasHorasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HorasModel info =
        ModalRoute.of(context)!.settings.arguments as HorasModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(info.city.name),
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
