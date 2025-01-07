
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'dart:ui' as ui;

class TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color startColor,endColor;
  final String? ticketType;

  static const _cornerGap = 25.0;
  static const _cutoutRadius = 25.0;
  static const _cutoutDiameter = _cutoutRadius * 2;

  TicketPainter({this.startColor=AppColors.primary, this.endColor=AppColors.secondary,
    required this.borderColor,this.ticketType});

  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = size.width;
    final maxHeight = size.height;

    final cutoutStartPos = /*ticketType=="business"?maxHeight - maxHeight * 0.32:*/maxHeight - maxHeight * 0.25;
    final leftCutoutStartY = cutoutStartPos;
    final rightCutoutStartY = cutoutStartPos - _cutoutDiameter;
    final dottedLineY = cutoutStartPos - _cutoutRadius;
    double dottedLineStartX = _cutoutRadius + 10;
    final double dottedLineEndX = maxWidth - _cutoutRadius - 15;
    const double dashWidth = 7;
    const double dashSpace = 5;

    final paintBg = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..shader=ui.Gradient.linear(
        Offset(0,0.5),
        Offset(1,0.5),
        [
          startColor,
          endColor,
        ],
      );
     // ..color = bgColor;

    final paintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    final paintDottedLine = Paint()
      ..color = borderColor.withOpacity(0.5)
      ..strokeWidth = 1.2;

    var path = Path();

    path.moveTo(_cornerGap, 0);
    path.lineTo(maxWidth - _cornerGap, 0);
    _drawCornerArc(path, maxWidth, _cornerGap);
    path.lineTo(maxWidth, rightCutoutStartY);
    _drawCutout(path, maxWidth, rightCutoutStartY + _cutoutDiameter);
    path.lineTo(maxWidth, maxHeight - _cornerGap); // Adjusted bottom height
    _drawCornerArc(path, maxWidth - _cornerGap, maxHeight); // Adjusted bottom height
    path.lineTo(_cornerGap, maxHeight); // Adjusted bottom height
    _drawCornerArc(path, 0, maxHeight - _cornerGap); // Adjusted bottom height
    path.lineTo(0, leftCutoutStartY);
    _drawCutout(path, 0.0, leftCutoutStartY - _cutoutDiameter);
    path.lineTo(0, _cornerGap);
    _drawCornerArc(path, _cornerGap, 0);

    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);

    while (dottedLineStartX < dottedLineEndX) {
      canvas.drawLine(
        Offset(dottedLineStartX, dottedLineY),
        Offset(dottedLineStartX + dashWidth, dottedLineY),
        paintDottedLine,
      );
      dottedLineStartX += dashWidth + dashSpace;
    }
  }

  _drawCutout(Path path, double startX, double endY) {
    path.arcToPoint(
      Offset(startX, endY),
      radius: const Radius.circular(_cutoutRadius),
      clockwise: false,
    );
  }

  _drawCornerArc(Path path, double endPointX, double endPointY) {
    path.arcToPoint(
      Offset(endPointX, endPointY),
      radius: const Radius.circular(_cornerGap),
    );
  }

  @override
  bool shouldRepaint(TicketPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TicketPainter oldDelegate) => false;
}