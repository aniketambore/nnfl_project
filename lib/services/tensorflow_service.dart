import 'dart:io';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class TensorFlowService {
  loadModel() async {
    var resultant = await Tflite.loadModel(
        model: "assets/models/model.tflite",
        labels: "assets/labels/labels.txt");

    print("After loading model $resultant");
  }

  predictImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return recognitions;
  }

  runModelOnFrame(CameraImage img) {
    var run = Tflite.runModelOnFrame(
      bytesList: img.planes.map((Plane plane) {
        return plane.bytes;
      }).toList(),
      imageWidth: img.width,
      imageHeight: img.height,
      numResults: 2,
    );
    return run;
  }
}
