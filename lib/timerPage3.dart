import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class timerPage3 extends StatefulWidget {
  const timerPage3({super.key});

  @override
  State<timerPage3> createState() => _timerPage3State();
}

class _timerPage3State extends State<timerPage3> with TickerProviderStateMixin {
  late AnimationController controller;
  final player = AudioPlayer();
  String get timerString {
    if(isRunning == false){
      controller.value=1;
      return '${controller.duration!.inMinutes}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    Duration duration = controller.duration! * controller.value;
    if (duration.inSeconds < 5 && duration.inSeconds > 0.00 && light == true) {
      player.play(AssetSource('sound.mp3'));
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    timerString;
  }

  bool light = true;
  bool isRunning = false;
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    controller.addStatusListener((status) {
      if (controller.status == AnimationStatus.dismissed) {
        setState(() => isRunning = false);
      }
  });
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 26, 38, 1),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
 const Text("Finish your meal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Text("You can eat until you feel full",
              style: TextStyle(
                color: Color.fromRGBO(108, 100, 132,1),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget? child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.black,
                                  color: themeData.indicatorColor,
                                ));
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget? child) {                                         
                                      return Text(
                                        timerString,
                                        style: const TextStyle(
                                            fontSize: 50.0,
                                            color: Colors.black),
                                      );
                                    }),
                                const Text(
                                  "minutes remaining",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Switch(
                // This bool value toggles the switch.
                value: light,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    light = value;
                  });
                },
              ),
            ),
            Container(
              child: light == true
                  ? const Text(
                      "Sound On",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  : const Text(
                      "Sound Off",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: isRunning
                          ? FloatingActionButton(
                              child: isPlaying
                                  ? const Text(
                                      "RESUME",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    )
                                  : const Text(
                                      "PAUSE",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                              onPressed: () {
                                
                                  setState(() => isPlaying = !isPlaying);
                                
                                if (controller.isAnimating) {
                                  controller.stop(canceled: true);
                                } else {
                                  controller.reverse(
                                      from: controller.value == 0.0
                                          ? 1.0
                                          : controller.value);
                                }
                              },
                            )
                          : FloatingActionButton(
                              child: const Text(
                                "START",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                setState(() => isRunning = !isRunning);
                                if (controller.isAnimating) {
                                  controller.stop(canceled: true);
                                } else {
                                  controller.reverse(
                                      from: controller.value == 0.0
                                          ? 1.0
                                          : controller.value);
                                }
                              },
                            ))
                ],
              ),
            ),
            isRunning == true
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: FloatingActionButton(
                          backgroundColor: Color.fromRGBO(26, 26, 38, 1),
                          child: const Text(
                            "LET'S STOP I'M FULL NOW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isRunning = false;
                              isPlaying = false;
                            });
                            controller.reset();
                          },
                        ))
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var radius = min(centerX, centerY);

    var dashBrush = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var outerradius = radius;
    var innerradius = radius - 10;

    for(var i=0;i<350;i+=6){
      var x1 = centerX + outerradius * cos(i * pi / 180);
      var y1 = centerY + outerradius * sin(i * pi / 180);

      var x2 = centerX + innerradius * cos(i * pi / 180);
      var y2 = centerY + innerradius * sin(i * pi / 180);
     
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
