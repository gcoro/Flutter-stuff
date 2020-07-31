import 'package:flutter/material.dart';

class BouncingAnimation extends StatefulWidget {
  @override
  _BouncingAnimationState createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _myAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _myAnimation = Tween(begin: 200.0, end: 120.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.elasticIn),
      ),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat(reverse: true);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    //-disposing the animation controller-
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () => _controller.forward(),
      child: AnimatedBuilder(
          animation: _myAnimation,
          builder: (ctx, ch) => Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                margin: EdgeInsets.only(top: _myAnimation.value, bottom: 20),
                decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage(
                  'assets/images/cat1.png',
                ))),
              )),
    ));
  }
}
