import 'package:flutter/material.dart';

import '../themes/themes.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
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
                  'https://torange.biz/photofxnew/1/HD/clear-sky-1049.jpg'),
              fit: BoxFit.cover,
            ),
            _InfoCenter(),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        title: const Text(
          'Cerdanyola del vallés',
          maxLines: 2,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            shadows: [
              AppTheme.shadow,
            ],
          ),
          textAlign: TextAlign.center,
        ),
        expandedTitleScale: 1.6,
        centerTitle: true,
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
    final style = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 250),
        const Text(
          '16ºC',
          style: TextStyle(
            fontSize: 80,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              AppTheme.shadow,
            ],
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nublado',
                    style: style.headline4,
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.cloud)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getCurrenthour(),
              style: style.headline4,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.location_on_sharp,
              size: 40,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
