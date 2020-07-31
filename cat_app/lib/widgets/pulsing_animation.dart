import 'package:flutter/material.dart';

class PulsingAnimation extends StatefulWidget {
  @override
  _PulsingAnimationState createState() => _PulsingAnimationState();
}

class _PulsingAnimationState extends State<PulsingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Size> _myAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _myAnimation = Tween<Size>(begin: Size(100, 100), end: Size(120, 120))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
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
                      width: _myAnimation.value.width,
                      height: _myAnimation.value.height,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                              image: new AssetImage(
                        'assets/images/heart.png',
                      ))),
                    ))));
  }
}
