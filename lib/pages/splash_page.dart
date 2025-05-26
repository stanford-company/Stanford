import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/routes/routes.dart';
import '../core/utils/app_themes.dart';
import '../core/utils/themebloc/theme_bloc.dart';
import '../data/pref_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Start timer to load next pages
    Timer(Duration(seconds: 3), () => _loadScreen());

    // Start animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  _loadScreen() async {
    await Prefs.load();
    context.read<ThemeBloc>().add(
      ThemeChanged(
        theme: Prefs.getBool(Prefs.DARKTHEME, def: false)
            ? AppTheme.DarkTheme
            : AppTheme.LightTheme,
      ),
    );
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/launcher_ic.png',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 30),
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) => CustomPaint(
                painter: RingPainter(_animation.value),
                child: SizedBox(width: 50, height: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double angle;

  RingPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Light green circular background
    final backgroundPaint = Paint()
      ..color = Colors.lightGreen.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Teal rotating arc
    final foregroundPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = pi / 2.5; // Arc length
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      angle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.angle != angle;
}
