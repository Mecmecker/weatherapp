import 'package:flutter/material.dart';

class MiniInfoCard extends StatelessWidget {
  final String text, unidades;
  final IconData icon;
  const MiniInfoCard(
      {Key? key,
      required this.text,
      required this.icon,
      required this.unidades})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        color: Colors.white.withOpacity(0.2),
        width: 120,
        height: 150,
        child: Center(
          child: Column(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text(text, style: style.headline5, textAlign: TextAlign.center),
              Text(unidades, style: style.headline5),
            ],
          ),
        ),
      ),
    );
  }
}
