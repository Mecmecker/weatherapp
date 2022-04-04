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
    final List<BoxShadow> shadows = [
      BoxShadow(
          color: Colors.white.withOpacity(0.3),
          offset: const Offset(4, 5),
          blurRadius: 4),
      BoxShadow(
          color: Colors.black38.withOpacity(0.1),
          offset: const Offset(5, 6),
          blurRadius: 10),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.2),
        boxShadow: shadows,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
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
    );
  }
}
