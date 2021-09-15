import 'dart:io';
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
}
