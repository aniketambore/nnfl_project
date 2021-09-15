import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nnfl_project/utils/colors.dart';

class ConfidenceMeter extends StatefulWidget {
  const ConfidenceMeter({
    required List<dynamic>? results,
    this.threshold = 0.5,
  }) : _results = results;
  final List<dynamic>? _results;
  final double threshold;

  @override
  _ConfidenceMeterState createState() => _ConfidenceMeterState();
}

class _ConfidenceMeterState extends State<ConfidenceMeter> {
  String? _label;
  double _confidence = 0;

  set label(String? value) => setState(() {
        _label = value;
      });

  set confidence(double value) => setState(() {
        _confidence = value;
      });

  String? get label => _label;

  double get confidence => _confidence;

  Color _changeBorderColor(
    BuildContext context,
    List<dynamic> divisions,
  ) {
    if (divisions == null) {
      return Colors.transparent;
    }

    if (divisions.length > 1) {
      final String firstLabel = divisions.first["label"] as String;
      final double firstConfidence = divisions.first["confidence"] as double;

      final String secondLabel = divisions.last["label"] as String;
      final double secondConfidence = divisions.last["confidence"] as double;

      if (firstConfidence > secondConfidence) {
        label = firstLabel;
        confidence = firstConfidence;
      } else {
        label = secondLabel;
        confidence = secondConfidence;
      }
    }
    if (divisions.length == 1) {
      label = divisions.first["label"] as String;
      confidence = divisions.first["confidence"] as double;
    }

    if (confidence < widget.threshold) {
      scheduleMicrotask(() => print("Don\'t Shake your mobile"));

      return Colors.transparent;
    }

    if (label == "Without Mask") {
      return flamingo;
    }

    if (label == "With Mask") {
      return carribean_green;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
              color: _changeBorderColor(
                context,
                widget._results!,
              ),
              width: 10,
            )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 85,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  label == "With Mask"
                      ? "Wearing mask " +
                          "${(confidence * 100).toStringAsFixed(0)}%"
                      : "No mask " +
                          "${(confidence * 100).toStringAsFixed(0)}%",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color:
                            label == "With Mask " ? carribean_green : flamingo,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
