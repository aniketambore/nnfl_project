import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nnfl_project/services/tensorflow_service.dart';
import 'package:nnfl_project/utils/colors.dart';
import 'dart:io';

class GalleryImagePreview extends StatefulWidget {
  @override
  _GalleryImagePreviewState createState() => _GalleryImagePreviewState();
}

class _GalleryImagePreviewState extends State<GalleryImagePreview> {
  final TensorFlowService _tensorFlowServices = TensorFlowService();
  File? _image;
  bool _isLoading = false;
  List? _recognitions;
  ImagePicker _picker = ImagePicker();
  String text = "";
  PickedFile? _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    loadModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  loadModel() async {
    _tensorFlowServices.loadModel();
  }

  selectImage() async {
    _imageFile = await _picker.getImage(source: ImageSource.gallery);
    if (_imageFile == null) return;
    setState(() {
      _isLoading = true;
      _image = File(_imageFile!.path);
    });
    predictImage(_image!);
  }

  predictImage(File image) async {
    var recognitions = await _tensorFlowServices.predictImage(image);
    setState(() {
      _isLoading = false;
      _recognitions = recognitions;
      text = _recognitions![0]["label"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.image,
          ),
          tooltip: "Pick Image From Gallery",
          onPressed: selectImage,
        ),
        appBar: AppBar(
          title: Text("Gallery Image Preview"),
          centerTitle: true,
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? Container(
                            child: Text(
                              "Select an Image to show preview.",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: foam,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: text == "Without Mask"
                                    ? flamingo
                                    : carribean_green,
                                width: 10,
                              ),
                            ),
                            child: Column(
                              children: [
                                Image.file(
                                  _image!,
                                  height:
                                      MediaQuery.of(context).size.height / 2 +
                                          60,
                                  width: MediaQuery.of(context).size.width - 80,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _recognitions != null
                                    ? Text(text,
                                        style: TextStyle(
                                            color: text == "Without Mask"
                                                ? flamingo
                                                : carribean_green,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold))
                                    : Container()
                              ],
                            )),
                  ],
                ),
              ));
  }
}
