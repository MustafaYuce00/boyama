import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coloring_provider.dart';
import '../models/coloring_template.dart';
import 'dart:ui' as ui;

class DrawingCanvas extends StatefulWidget {
  final ColoringTemplate? template;
  
  const DrawingCanvas({super.key, this.template});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ColoringProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: GestureDetector(
            onPanStart: (details) {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(details.globalPosition);
              provider.addPoint(localPosition);
            },
            onPanUpdate: (details) {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final localPosition = renderBox.globalToLocal(details.globalPosition);
              provider.addPoint(localPosition);
            },
            onPanEnd: (details) {
              provider.endStroke();
            },
            child: CustomPaint(
              painter: DrawingPainter(
                points: provider.points,
                pointColors: provider.pointColors,
                strokeWidth: provider.strokeWidth,
                template: widget.template,
              ),
              size: Size.infinite,
            ),
          ),
        );
      },
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<ui.Offset?> points;
  final List<Color> pointColors;
  final double strokeWidth;
  final ColoringTemplate? template;

  DrawingPainter({
    required this.points,
    required this.pointColors,
    required this.strokeWidth,
    this.template,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Arka plan şablonları çiz (gelecekte eklenecek)
    _drawTemplate(canvas, size);
    
    // Kullanıcının çizimlerini çiz
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        final paint = Paint()
          ..color = pointColors[i]
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // Tek nokta çiz
        final paint = Paint()
          ..color = pointColors[i]
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(points[i]!, strokeWidth / 2, paint);
      }
    }
  }

  void _drawTemplate(Canvas canvas, Size size) {
    if (template != null) {
      // Seçilen şablonu çiz
      final templatePaint = Paint()
        ..color = Colors.grey[300]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      for (final templatePath in template!.paths) {
        canvas.drawPath(templatePath.path, templatePaint);
      }
    } else {
      // Varsayılan şablon - basit kedi figürü
      final templatePaint = Paint()
        ..color = Colors.grey[300]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      final centerX = size.width / 2;
      final centerY = size.height / 2;

      // Kedi kafası (daire)
      canvas.drawCircle(
        Offset(centerX, centerY - 50),
        80,
        templatePaint,
      );

      // Kulaklar
      canvas.drawCircle(
        Offset(centerX - 50, centerY - 100),
        25,
        templatePaint,
      );
      canvas.drawCircle(
        Offset(centerX + 50, centerY - 100),
        25,
        templatePaint,
      );

      // Gözler
      canvas.drawCircle(
        Offset(centerX - 25, centerY - 70),
        10,
        templatePaint,
      );
      canvas.drawCircle(
        Offset(centerX + 25, centerY - 70),
        10,
        templatePaint,
      );

      // Burun
      final nosePath = Path();
      nosePath.moveTo(centerX, centerY - 40);
      nosePath.lineTo(centerX - 10, centerY - 25);
      nosePath.lineTo(centerX + 10, centerY - 25);
      nosePath.close();
      canvas.drawPath(nosePath, templatePaint);

      // Ağız
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(centerX, centerY - 15),
          width: 30,
          height: 20,
        ),
        0,
        3.14, // π radyan (yarım daire)
        false,
        templatePaint,
      );

      // Vücut (oval)
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, centerY + 80),
          width: 100,
          height: 120,
        ),
        templatePaint,
      );

      // Pençeler
      canvas.drawCircle(
        Offset(centerX - 60, centerY + 120),
        20,
        templatePaint,
      );
      canvas.drawCircle(
        Offset(centerX + 60, centerY + 120),
        20,
        templatePaint,
      );

      // Kuyruk
      final tailPath = Path();
      tailPath.moveTo(centerX + 80, centerY + 40);
      tailPath.quadraticBezierTo(
        centerX + 120,
        centerY,
        centerX + 100,
        centerY - 40,
      );
      canvas.drawPath(tailPath, templatePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
