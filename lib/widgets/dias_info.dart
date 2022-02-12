import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiasInfoWidget extends StatelessWidget {
  const DiasInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: ((context, index) => const _MiniDiaInfo()),
          itemCount: 16,
          itemExtent: 55,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class _MiniDiaInfo extends StatelessWidget {
  const _MiniDiaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Vie Feb 11',
            style: style.headline5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Max 12º',
                  style: TextStyle(color: Colors.red[300], fontSize: 16),
                ),
                const TextSpan(text: ' | '),
                TextSpan(
                  text: 'Min 6º',
                  style: TextStyle(color: Colors.blue[300], fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(FontAwesomeIcons.temperatureHigh),
      ),
      leading: const Icon(FontAwesomeIcons.cloudRain),
    );
  }
}
