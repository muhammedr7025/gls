import 'dart:ui';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

class GasDtail extends StatefulWidget {
  const GasDtail({Key? key}) : super(key: key);

  @override
  State<GasDtail> createState() => _GasDtailState();
}

class _GasDtailState extends State<GasDtail> {
  late double gasLevel = 0;
  late String outflow = "safe";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
          body: Center(
              child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  Text(
                    "Gas outflow:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  outflow == "safe"
                      ? Container(
                          color: Colors.yellow,
                          width: 80,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Safe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.green),
                            ),
                          ),
                        )
                      : Text(
                          "At risk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red),
                        )
                ],
              ),
            ),
          ),
          Container(
              child: SfRadialGauge(
                  title: GaugeTitle(
                      text: 'Gas level',
                      textStyle: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 100.001,
                    pointers: <GaugePointer>[
                      NeedlePointer(value: gasLevel)
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: 20,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 20,
                          endValue: 50,
                          color: Colors.orange,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 50,
                          endValue: 100,
                          color: Colors.green,
                          startWidth: 10,
                          endWidth: 10)
                    ]),
              ])),
        ],
      ))),
    ));
  }
}
