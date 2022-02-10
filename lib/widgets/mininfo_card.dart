import 'package:flutter/material.dart';

class MiniInfoCard extends StatelessWidget {
  const MiniInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 120,
        height: 150,
        color: Colors.red,
      ),
    );
  }
}
