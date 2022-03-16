import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          child: _SelectLayerBar()),
    );
  }
}

class _SelectLayerBar extends StatelessWidget {
  const _SelectLayerBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LayerProvider layerProvider = Provider.of<LayerProvider>(context);
    return BottomNavigationBar(
      currentIndex: layerProvider.layerPos,
      onTap: (pos) {
        layerProvider.layerPos = pos;
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.thermostat),
          label: 'Temperatura',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Lluvia',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.window),
          label: 'Viento',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart_rounded),
          label: 'Nubes',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart_rounded),
          label: 'Lluvia acumulada',
          backgroundColor: Color.fromARGB(255, 15, 19, 51),
        ),
      ],
    );
  }
}
