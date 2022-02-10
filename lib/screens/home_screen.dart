import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _MaxMinDescription(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    PercentCircle(text: 'Humidity'),
                    PercentCircle(text: 'Cloudiness'),
                  ],
                ),
                const _ActualWeatherWidgetsInfo(),
                Container(
                  height: 1000,
                  color: Colors.green,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ActualWeatherWidgetsInfo extends StatelessWidget {
  const _ActualWeatherWidgetsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          MiniInfoCard(),
          MiniInfoCard(),
          MiniInfoCard(),
        ],
      ),
    );
  }
}

class _MaxMinDescription extends StatelessWidget {
  const _MaxMinDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Max 16º',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(width: 5),
              Text('Min 6º', style: TextStyle(fontSize: 28)),
              SizedBox(width: 30),
              Text('5 Marzo', style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Cielo bastante nublado', style: TextStyle(fontSize: 28))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      expandedHeight: size.height - 130,
      floating: false,
      pinned: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      centerTitle: true,
      automaticallyImplyLeading: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: const [
            FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2020/02/05/10/19/sunshine-4820723_960_720.jpg'),
              fit: BoxFit.cover,
            ),
            _InfoCenter(),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        title: const Text('Barcelona'),
        centerTitle: true,
        expandedTitleScale: 2,
      ),
    );
  }
}

class _InfoCenter extends StatelessWidget {
  const _InfoCenter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 250),
      const Text(
        '16ºC',
        style: TextStyle(
            fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      Column(
        children: [
          Container(
            color: Colors.green,
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Barcelona'),
                SizedBox(width: 18),
                Icon(Icons.gps_fixed),
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            height: 50,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Nublado'),
                  SizedBox(width: 18),
                  Icon(Icons.cloud)
                ],
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
