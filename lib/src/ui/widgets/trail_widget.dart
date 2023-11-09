import 'package:flutter/material.dart';

class TrailWidget extends StatelessWidget {
  final Offset? previousPosition;
  final Offset? currentPosition;

  const TrailWidget({Key? key, this.previousPosition, this.currentPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(0, 100),
      painter: TrailPainter(previousPosition, currentPosition),
    );
  }
}

class TrailPainter extends CustomPainter {
  final Offset? previousPosition;
  final Offset? currentPosition;

  TrailPainter(this.previousPosition, this.currentPosition);

  @override
  void paint(Canvas canvas, Size size) {
    if (previousPosition != null && currentPosition != null) {
      final paint = Paint()
        ..color = Colors.blue
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2.0;

      const trailOpacity = 1.0;

      final path = Path();
      path.moveTo(previousPosition!.dx, previousPosition!.dy);
      path.lineTo(currentPosition!.dx, currentPosition!.dy);

      const currentOpacity = trailOpacity;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
