import 'package:flutter/material.dart';
import 'dash_path_type.dart';

class DashedPath extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final DashPathType type;

  const DashedPath({
    super.key,
    required this.color,
    this.strokeWidth = 2,
    this.dashLength = 6,
    this.dashGap = 4,
    this.type = DashPathType.straight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPathPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashGap: dashGap,
        type: type,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _DashedPathPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final DashPathType type;

  const _DashedPathPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    required this.type,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = _buildPath(size);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance);
        if (pos != null) {
          canvas.drawRect(
            Rect.fromCenter(
              center: pos.position,
              width: strokeWidth,
              height: strokeWidth * 1.4,
            ),
            paint,
          );
        }
        distance += dashLength + dashGap;
      }
    }
  }

  Path _buildPath(Size size) {
    switch (type) {
      case DashPathType.straight:
        return _buildStraight(size);
      case DashPathType.curveRightDown:
        return _buildRightDown(size);
      case DashPathType.curveRightUp:
        return _buildRightUp(size);
      case DashPathType.curveLeftDown:
        return _buildMirrored(size, _buildRightDown(size));
      case DashPathType.curveLeftUp:
        return _buildMirrored(size, _buildRightUp(size));
    }
  }

  Path _buildStraight(Size size) {
    final path = Path();
    final midY = size.height / 2;
    path.moveTo(0, midY);
    path.lineTo(size.width, midY);
    return path;
  }

  Path _buildRightDown(Size size) {
    final path = Path();
    final r = size.height * 0.5;
    final midY = size.height / 2;

    path.moveTo(0, midY);
    path.lineTo(size.width - r, midY);

    final rect = Rect.fromLTWH(size.width - 2 * r, midY, 2 * r, 2 * r);

    path.arcTo(rect, -3.14159 / 2, 3.14159 / 2, false);
    return path;
  }

  Path _buildRightUp(Size size) {
    final path = Path();
    final r = size.height * 0.5;
    final midY = size.height / 2;

    path.moveTo(0, midY);
    path.lineTo(size.width - r, midY);

    final rect = Rect.fromLTWH(size.width - 2 * r, midY - 2 * r, 2 * r, 2 * r);

    path.arcTo(rect, 3.14159 / 2, -3.14159 / 2, false);
    return path;
  }

  Path _buildMirrored(Size size, Path original) {
    final matrix = Matrix4.translationValues(size.width, 0, 0)
      ..multiply(Matrix4.diagonal3Values(-1, 1, 1));
    return original.transform(matrix.storage);
  }

  @override
  bool shouldRepaint(covariant _DashedPathPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.type != type;
  }
}
