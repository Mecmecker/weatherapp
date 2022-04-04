import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Más',
            style: style.headline5,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
