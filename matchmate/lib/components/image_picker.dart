import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matchmate/components/constants.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: GradientBoxBorder(
                gradient: gradient,
                width: 3,
              ),
            ),
            child: image != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: MemoryImage(image!),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    foregroundImage: AssetImage("assets/profile.jpeg"),
                  ),
          ),
          Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 30,
                color: kColor1,
              ),
              onPressed: () {
                bottomSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    Navigator.of(context).pop();
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _setImage(File(pickedFile.path));
    }

    Navigator.of(context).pop();
  }

  void _setImage(File imageFile) {
    setState(() {
      selectedImage = imageFile;
      image = imageFile.readAsBytesSync();
    });
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: Color.fromRGBO(199, 0, 57, 0.8),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
