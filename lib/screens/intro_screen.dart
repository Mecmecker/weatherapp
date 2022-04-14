import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/screens/screens.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  final double _bigFontSize = kIsWeb ? 234 : 110;
  final transitionDuration = const Duration(milliseconds: 800);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => setState(() => expanded = true))
        .then((value) => const Duration(milliseconds: 300))
        .then(
          (value) => Future.delayed(const Duration(milliseconds: 300)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false),
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: Stack(children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFec8927),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: transitionDuration,
                      curve: Curves.fastOutSlowIn,
                      style: TextStyle(
                        color: const Color(0xFFded9d9),
                        fontSize: !expanded ? _bigFontSize : 50,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                      child: const Text(
                        "W",
                      ),
                    ),
                    AnimatedCrossFade(
                      firstCurve: Curves.fastOutSlowIn,
                      crossFadeState: !expanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: transitionDuration,
                      firstChild: Container(),
                      secondChild: _logoRemainder(),
                      alignment: Alignment.centerLeft,
                      sizeCurve: Curves.easeInOut,
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstCurve: Curves.fastOutSlowIn,
                  crossFadeState: !expanded
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: transitionDuration,
                  firstChild: Container(),
                  secondChild: _logoRemainderBottom(),
                  alignment: Alignment.centerLeft,
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedCrossFade(
            firstCurve: Curves.bounceIn,
            crossFadeState: !expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: transitionDuration,
            firstChild: SizedBox(
              width: width * 0.5,
              height: 80,
            ),
            secondChild: SizedBox(
              width: width * 0.5,
              height: 80,
              child: Image.asset('assets/upcbrand.png'),
            ),
            alignment: Alignment.centerLeft,
            sizeCurve: Curves.easeInOut,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: AnimatedCrossFade(
            firstCurve: Curves.bounceIn,
            crossFadeState: !expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: transitionDuration,
            firstChild: SizedBox(
              width: width * 0.3,
              height: 30,
            ),
            secondChild: SizedBox(
              width: width * 0.3,
              height: 30,
              child: const Center(
                child: Text(
                  'By Daniel Muñoz',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            sizeCurve: Curves.easeInOut,
          ),
        ),
      ]),
    );
  }

  Widget _logoRemainder() {
    return const Text(
      "EATHER",
      style: TextStyle(
        color: Color(0xFFded9d9),
        fontSize: 50,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _logoRemainderBottom() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "APP",
          style: TextStyle(
            color: Color.fromARGB(255, 5, 87, 114),
            fontSize: 80,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        LottieBuilder.asset(
          'assets/cargaNubes.json',
          onLoaded: (composition) {
            _lottieAnimation.duration = composition.duration;
          },
          frameRate: FrameRate.max,
          repeat: false,
          animate: false,
          height: 150,
          width: 150,
          controller: _lottieAnimation,
        )
      ],
    );
  }
}
