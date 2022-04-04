import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          BoxShadow(
              color: Color.fromARGB(95, 248, 135, 14),
              spreadRadius: 0,
              blurRadius: 10),
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
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.thermostat),
          label: 'Temperatura',
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.cloudRain),
          label: 'Lluvia',
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.wind),
          label: 'Viento',
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.cloudSun),
          label: 'Nubes',
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.rulerVertical),
          label: 'mm/ Acum',
          backgroundColor: Colors.white.withOpacity(0.2),
        ),
      ],
    );
  }
}
