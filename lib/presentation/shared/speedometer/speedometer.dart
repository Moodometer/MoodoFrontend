import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'painter.dart';

class Speedometer extends StatefulWidget {
  const Speedometer(
      {Key? key,
      this.size = 200,
      this.minValue = 0,
      this.maxValue = 100,
      this.currentValue = 0,
      this.warningValue = 80,
      this.backgroundColor = const Color(0xFF55C6F9),
      this.meterColor = Colors.lightGreenAccent,
      this.warningColor = Colors.redAccent,
      this.kimColor = Colors.white,
      this.displayNumericStyle =
          const TextStyle(color: Colors.transparent, fontSize: 25),
      this.displayText = '',
      this.displayTextStyle = const TextStyle(
        color: Colors.white,
        fontSize: 40,
      )})
      : super(key: key);
  final double size;
  final int minValue;
  final int maxValue;
  final int currentValue;
  final int warningValue;
  final Color backgroundColor;
  final Color meterColor;
  final Color warningColor;
  final Color kimColor;
  final TextStyle displayNumericStyle;
  final String displayText;
  final TextStyle displayTextStyle;
  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    double size = widget.size;
    int minValue = widget.minValue;
    int maxValue = widget.maxValue;
    int currentValue = widget.currentValue;
    int warningValue = widget.warningValue;
    double startAngle = 3.0;
    double endAngle = 21.0;

    double kimAngle = 0;
    if (minValue <= currentValue && currentValue <= maxValue) {
      kimAngle = (((currentValue - minValue) * (endAngle - startAngle)) /
              (maxValue - minValue)) +
          startAngle;
    } else if (currentValue < minValue) {
      kimAngle = startAngle;
    } else if (currentValue > maxValue) {
      kimAngle = endAngle;
    }

    double startAngle2 = 0.0;
    double endAngle2 = 18.0;
    double warningAngle = endAngle2;
    if (minValue <= warningValue && warningValue <= maxValue) {
      warningAngle = (((warningValue - minValue) * (endAngle2 - startAngle2)) /
              (maxValue - minValue)) +
          startAngle2;
    }

    double angle = math.pi / 12 * kimAngle;
    double oldAngle = 0.0;
    double angleDelta = 0.0;
    return Container(
      color: widget.backgroundColor,
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(size * 0.075),
                  child: Stack(children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          color: widget.backgroundColor,
                          boxShadow: [
                            BoxShadow(
                                color: widget.kimColor,
                                blurRadius: 8.0,
                                spreadRadius: 4.0)
                          ],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: Size(size, size),
                      painter: ArcPainter(
                          startAngle: 9,
                          sweepAngle: 18,
                          color: widget.warningColor),
                    ),
                    CustomPaint(
                      size: Size(size, size),
                      painter: ArcPainter(
                          startAngle: 9,
                          sweepAngle: warningAngle,
                          color: widget.meterColor),
                    ),
                  ]),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      width: size,
                      height: size * 0.5,
                      color: widget.backgroundColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: size * 0.1,
                    height: size * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.kimColor,
                      boxShadow: [
                        BoxShadow(
                            color: widget.meterColor,
                            blurRadius: 10.0,
                            spreadRadius: 5.0)
                      ],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: angle,
                    child: ClipPath(
                      clipper: KimClipper(),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        /* onPanStart: (details) {
                        final touchPositionFromCenter =
                            details.localPosition - centerOfGestureDetector;
                        angleDelta =
                            oldAngle - touchPositionFromCenter.direction;
                      },
                      onPanEnd: (details) {
                        setState(
                          () {
                            oldAngle = angle;
                          },
                        );
                      }, */
                        onPanUpdate: (details) => setState(() {
                          angle = angle - details.localPosition.direction;
                          log(angle.toString());
                        }),
                        child: Container(
                          width: size * 0.9,
                          height: size * 0.9,
                          color: widget.kimColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      widget.displayText,
                      style: widget.displayTextStyle,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size * 0.1),
                    child: Text(
                      widget.currentValue.toString(),
                      style: widget.displayNumericStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
