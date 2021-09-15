import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nnfl_project/services/tensorflow_service.dart';
import 'package:nnfl_project/utils/colors.dart';
import 'package:nnfl_project/widgets/confidence_meter.dart';

class CameraPreviewScreen extends StatefulWidget {
  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen>
    with WidgetsBindingObserver {
  final TensorFlowService _tensorFlowService = TensorFlowService();
  CameraController? _controller;
  bool _isDetecting = false;

  bool _rear = false;
  List<CameraDescription> _cameras = [];
  List<dynamic>? _recognitions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    loadModel();
    _setupCamera();
  }

  loadModel() async {
    _tensorFlowService.loadModel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _setupCamera();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  void _setupCamera() async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras.isEmpty) {
      print("No Camera Available.");
    } else {
      _controller = CameraController(
        _cameras[_rear ? 0 : 1],
        ResolutionPreset.max,
      );
      _controller!.initialize().then((_) {
        if (_updateCamera()) {
          _readFrames();
        }
      });
    }
  }

  Future<void> _switchCameraLens() async {
    _rear = !_rear;
    await _controller?.dispose();
    _setupCamera();
  }

  bool _updateCamera() {
    if (!mounted) {
      return false;
    }
    setState(() {});
    return true;
  }

  void _updateRecognitions({
    required List<dynamic>? recognitions,
  }) {
//    setState(() {
//      _recognitions = recognitions!;
//    });
  }

  void _readFrames() {
    _controller!.startImageStream(
      (CameraImage img) {
        if (!_isDetecting) {
          _isDetecting = true;
          _tensorFlowService
              .runModelOnFrame(img)
              .then((List<dynamic>? recognitions) {
            _updateRecognitions(
              recognitions: recognitions,
            );
            _isDetecting = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }

    final Size screen = MediaQuery.of(context).size;
    final double screenH = max(screen.height, screen.width);
    final double screenW = min(screen.height, screen.width);

    final Size? previewSize = _controller!.value.previewSize;
    final double previewH = max(previewSize!.height, previewSize.width);
    final double previewW = min(previewSize.height, previewSize.width);
    final double screenRatio = screenH / screenW;
    final double previewRatio = previewH / previewW;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          OverflowBox(
            maxHeight: screenRatio > previewRatio
                ? screenH
                : screenW / previewW * previewH,
            maxWidth: screenRatio > previewRatio
                ? screenH / previewH * previewW
                : screenW,
            child: CameraPreview(_controller!),
          ),
          ConfidenceMeter(
            results: _recognitions ?? <dynamic>[],
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: carribean_green),
              child: GestureDetector(
                  onTap: () async => _switchCameraLens(),
                  child: Icon(
                    _rear ? Icons.camera_front : Icons.camera_rear,
                    size: 30,
                    color: white,
                  )),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80), color: flamingo),
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.exit_to_app,
                    size: 30,
                    color: white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
