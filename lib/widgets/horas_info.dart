import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HorasInfoWidget extends StatelessWidget {
  const HorasInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: ((context, index) => const _MiniHoraInfo()),
        itemCount: 16,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _MiniHoraInfo extends StatelessWidget {
  const _MiniHoraInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return SizedBox(
      height: 90,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '17:00',
            style: style.headline6,
          ),
          const Icon(FontAwesomeIcons.sun),
          Text('14ºC', style: style.headline5)
        ],
      ),
    );
  }
}
